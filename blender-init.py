import os
import sys
try:
    import bpy
except: 
    os.system('D:/Apps/Blender/blender.exe --factory-startup --python "blender-init.py"')
    sys.exit()

VERSION = "3.3"

os.system("rd /S /Q D:\\Apps\\Blender\\"+VERSION+"\\config")
os.system("mkdir D:\\Apps\\Blender\\"+VERSION+"\\config")

bpy.context.preferences.use_preferences_save = False
bpy.context.preferences.view.show_splash = False
bpy.context.preferences.view.show_developer_ui = True
bpy.context.preferences.view.show_tooltips_python = True
bpy.context.preferences.view.color_picker_type = "SQUARE_SV"
bpy.context.preferences.view.render_display_type = "NONE"
bpy.context.preferences.view.show_statusbar_stats = False
bpy.context.preferences.view.show_statusbar_memory = True
bpy.context.preferences.view.show_statusbar_vram = True
bpy.context.preferences.view.use_text_antialiasing = True
bpy.context.preferences.view.text_hinting = "FULL"
bpy.context.preferences.system.viewport_aa = "OFF"
bpy.context.preferences.system.gl_texture_limit = "CLAMP_4096"
bpy.context.preferences.system.use_gpu_subdivision = True # speed up viewport (raise GPU temp)
bpy.context.preferences.themes[0].view_3d.space.gradients.high_gradient.r = 0.222
bpy.context.preferences.themes[0].view_3d.space.gradients.high_gradient.g = 0.233
bpy.context.preferences.themes[0].view_3d.space.gradients.high_gradient.b = 0.255
#bpy.context.preferences.filepaths.texture_directory = "D:\\Media\\Textures\\"
#bpy.context.preferences.filepaths.script_directory = "D:\\Repository\\blender-scripts\\"
bpy.context.preferences.filepaths.image_editor = "D:\\Apps\\Photoshop\\Photoshop.exe"

bpy.ops.script.reload() # reload script_directory

# Addons
bpy.ops.preferences.addon_disable(module='io_scene_x3d')
bpy.ops.preferences.addon_disable(module='io_mesh_ply')
#bpy.ops.preferences.addon_enable(module='custom_user_interface')

# Keyconfigs
bpy.ops.preferences.keyconfig_activate(filepath="D:\\Apps\\Blender\\"+VERSION+"\\scripts\\presets\\keyconfig\\industry_compatible.py")

# Cycles CUDA
bpy.ops.screen.userpref_show('INVOKE_DEFAULT')
bpy.context.preferences.active_section = "SYSTEM"
bpy.context.preferences.addons['cycles'].preferences.compute_device_type = 'CUDA'

bpy.ops.wm.save_userpref()
