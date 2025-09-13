//
// XMon hardware monitor (X11/Wayland)
//
// I first wrote this program in a gnome-extension (it was slow),
// then it was written in bash (it wasn't accurate and a bit slow, bash version: .trash/hw-xmon.sh),
// and now it's written in C, which is significantly more responsive!
//
// - Mem usage from ~380-480 KB multiple-processes -> to only ~100 KB single-process
// - There is no startup delay (3s to 0s)
// - Display network rate in KB/s per second instead of bytes
// - The only resource consumption of this program is xterm itself! (5.7 MB memory)
//
// To make it even better, there are a few things that can be done later:
// - calculating the time difference in CPU usage in 1 second
// - automatic testing and identification of the CPU thermal_zone
// - automatic detection of active network interface
//
// But now you need to compile it, although it is written without any dependencies
// and compiling it is as simple as the following command:
// 
// $ gcc -o hw-xmon hw-xmon.c
//
// Start: hw-xmon-start.sh (recommended way to run the program)


#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <time.h>

 
#define MAX_BUFFER_LEN 1024

const char* cpu_thermal_zone = "/sys/class/thermal/thermal_zone2/temp";
const char* net_interface = "wlx"; // (enp: ethernet | wlx: wifi)


void get_cpu_usage(float *cpu_usage) {
    FILE *fp;
    char buffer[MAX_BUFFER_LEN];
    unsigned long long user, nice, system, idle, iowait, irq, softirq, steal;
    unsigned long long total_idle, total_non_idle, total;
    static unsigned long long prev_total = 0, prev_idle = 0;
    
    fp = fopen("/proc/stat", "r");
    if (fp == NULL) {
        perror("Error opening /proc/stat");
        return;
    }
    
    fgets(buffer, sizeof(buffer), fp);
    sscanf(buffer, "cpu %llu %llu %llu %llu %llu %llu %llu %llu", 
           &user, &nice, &system, &idle, &iowait, &irq, &softirq, &steal);
    
    fclose(fp);
    
    total_idle = idle + iowait;
    total_non_idle = user + nice + system + irq + softirq + steal;
    total = total_idle + total_non_idle;
    
    if (prev_total != 0) {
        unsigned long long diff_total = total - prev_total;
        unsigned long long diff_idle = total_idle - prev_idle;
        *cpu_usage = (diff_total - diff_idle) * 100.0 / diff_total;
    }
    
    prev_total = total;
    prev_idle = total_idle;
}


void get_cpu_temp(int *cpu_temp) {
    FILE *fp;
    char buffer[MAX_BUFFER_LEN];
    int temp;
    
    fp = fopen(cpu_thermal_zone, "r");
    if (fp == NULL) {
        perror("Error opening thermal zone file");
        return;
    }
    
    fgets(buffer, sizeof(buffer), fp);
    fclose(fp);
    
    temp = atoi(buffer);
    *cpu_temp = temp / 1000;  // millidegrees to degrees
}


void get_gpu_usage(float *usage, float *mem_usage, int *temp, int *fan_speed) {
    FILE *fp;
    char buffer[MAX_BUFFER_LEN];
    char *token;
    int gpu_usage = 0;
    int gpu_mem_total = 0;
    int gpu_mem_used = 0;
    int gpu_temp = 0;
    int gpu_fan_speed = 0;

    fp = popen("nvidia-smi --query-gpu=utilization.gpu,memory.total,memory.used,temperature.gpu,fan.speed --format=csv,noheader,nounits", "r");
    if (fp == NULL) {
        perror("Error executing nvidia-smi");
        return;
    }
    
    if (fgets(buffer, sizeof(buffer), fp) != NULL) {
        buffer[strcspn(buffer, "\n")] = 0;  // remove newline if present

        token = strtok(buffer, ", ");
        gpu_usage = atoi(token);
        token = strtok(NULL, ", ");
        gpu_mem_total = atoi(token);
        token = strtok(NULL, ", ");
        gpu_mem_used = atoi(token);
        token = strtok(NULL, ", ");
        gpu_temp = atoi(token);
        token = strtok(NULL, ", ");
        gpu_fan_speed = atoi(token);

        *usage = (float)gpu_usage;
        *mem_usage = ((float)gpu_mem_used * 100.0) / (float)gpu_mem_total;
        *temp = gpu_temp;
        *fan_speed = gpu_fan_speed;
    }
    
    pclose(fp);
}


void get_mem_usage(float *mem_usage) {
    FILE *fp;
    char buffer[MAX_BUFFER_LEN];
    unsigned long long total_mem, free_mem, buffers, cached, sreclaimable, shmem, sunreclaim;

    fp = fopen("/proc/meminfo", "r");
    if (fp == NULL) {
        perror("Error opening /proc/meminfo");
        return;
    }
    
    total_mem = 0;
    free_mem = 0;
    buffers = 0;
    cached = 0;
    sreclaimable = 0;
    shmem = 0;
    sunreclaim = 0;
    
    while (fgets(buffer, sizeof(buffer), fp) != NULL) {
        if (strstr(buffer, "MemTotal:")) {
            sscanf(buffer, "MemTotal: %lu kB", &total_mem);
        } else if (strstr(buffer, "MemFree:")) {
            sscanf(buffer, "MemFree: %lu kB", &free_mem);
        } else if (strstr(buffer, "Buffers:")) {
            sscanf(buffer, "Buffers: %lu kB", &buffers);
        } else if (strstr(buffer, "Cached:")) {
            sscanf(buffer, "Cached: %lu kB", &cached);
        } else if (strstr(buffer, "SReclaimable:")) {
            sscanf(buffer, "SReclaimable: %lu kB", &sreclaimable);
        } else if (strstr(buffer, "Shmem:")) {
            sscanf(buffer, "Shmem: %lu kB", &shmem);
        } else if (strstr(buffer, "SUnreclaim:")) {
            sscanf(buffer, "SUnreclaim: %lu kB", &sunreclaim);
        }
    }
    
    fclose(fp);
    
    unsigned long long used_mem = total_mem - free_mem - buffers - cached + sreclaimable + shmem + sunreclaim;
    *mem_usage = (used_mem * 100.0) / total_mem;
}


void get_swap_usage(float *swap_usage) {
    FILE *fp;
    char buffer[MAX_BUFFER_LEN];
    unsigned long long total_swap, free_swap;
    
    fp = fopen("/proc/meminfo", "r");
    if (fp == NULL) {
        perror("Error opening /proc/meminfo");
        return;
    }
    
    total_swap = 0;
    free_swap = 0;
    
    while (fgets(buffer, sizeof(buffer), fp) != NULL) {
        if (strstr(buffer, "SwapTotal:")) {
            sscanf(buffer, "SwapTotal: %lu kB", &total_swap);
        } else if (strstr(buffer, "SwapFree:")) {
            sscanf(buffer, "SwapFree: %lu kB", &free_swap);
        }
    }
    
    fclose(fp);
    
    if (total_swap > 0) {
        *swap_usage = ((total_swap - free_swap) * 100.0) / total_swap;
    } else {
        *swap_usage = 0.0;
    }
}


void get_network_rate(double *rx_rate, double *tx_rate) {
    FILE *fp;
    char buffer[MAX_BUFFER_LEN];
    char interface[32];
    unsigned long long rx_bytes, tx_bytes;
    static unsigned long long prev_rx_bytes = 0, prev_tx_bytes = 0;
    static time_t prev_time = 0;
    time_t current_time;
    double time_diff;
    
    fp = fopen("/proc/net/dev", "r");
    if (fp == NULL) {
        perror("Error opening /proc/net/dev");
        return;
    }
    
    // skip the first two lines (header)
    fgets(buffer, sizeof(buffer), fp);
    fgets(buffer, sizeof(buffer), fp);
    
    rx_bytes = 0;
    tx_bytes = 0;
    
    while (fgets(buffer, sizeof(buffer), fp) != NULL) {
        sscanf(buffer, "%s %llu %*u %*u %*u %*u %*u %*u %*u %llu",
                interface, &rx_bytes, &tx_bytes);
        
        // skip loopback interface
        if (strcmp(interface, "lo:") == 0) {
            continue;
        }

        if (strncmp(interface, net_interface, 3) == 0) {
            break;
        }
    }
    
    fclose(fp);
    
    current_time = time(NULL);
    time_diff = difftime(current_time, prev_time);
    
    if (prev_time != 0 && time_diff > 0) {
        *rx_rate = (rx_bytes - prev_rx_bytes) / time_diff;
        *tx_rate = (tx_bytes - prev_tx_bytes) / time_diff;
    }
    
    prev_rx_bytes = rx_bytes;
    prev_tx_bytes = tx_bytes;
    prev_time = current_time;
}


int main() {
    int cpu_temp, gpu_temp, gpu_fan_speed;
    float cpu_usage, mem_usage, swap_usage, gpu_usage, gpu_mem_usage;
    double rx_rate, tx_rate;

    printf("\e[?25l"); // hide cursor
    fflush(stdout);
    
    while (1) {
        get_cpu_usage(&cpu_usage);
        get_cpu_temp(&cpu_temp);
        get_gpu_usage(&gpu_usage, &gpu_mem_usage, &gpu_temp, &gpu_fan_speed);
        get_mem_usage(&mem_usage);
        get_swap_usage(&swap_usage);
        get_network_rate(&rx_rate, &tx_rate);
        
        fputs("\033[H\033[2J", stdout);
        printf("\033[96mCPU  %.1f%%  %d°c\033[0m\n", cpu_usage, cpu_temp);
        printf("\033[92mGPU  %.1f%%  %d°c  %.1f%%  %d%%\033[0m\n", gpu_usage, gpu_temp, gpu_mem_usage, gpu_fan_speed);
        printf("\033[93mMEM  %.1f%% (%.1f%%)\033[0m\n", mem_usage, swap_usage);
        printf("\033[97mNET  ↓ %.1f ↑ %.1f KB/s\033[0m", rx_rate/1024, tx_rate/1024);
        fflush(stdout);
        
        sleep(1.5);
    }
    
    return 0;
}
