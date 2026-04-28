--[[
Barras animadas con efecto glow para Conky
~/.config/conky/lua-bars/bars.lua
]]

-- Intentar cargar cairo de diferentes formas
local cairo_loaded = false
local cairo

-- Método 1: Usar lgi (recomendado)
local status, lgi = pcall(require, 'lgi')
if status then
    cairo = lgi.cairo
    cairo_loaded = true
else
    -- Método 2: Intentar cargar cairo directamente
    status = pcall(require, 'cairo')
    if status then
        cairo_loaded = true
    end
end

if not cairo_loaded then
    print("ERROR: No se pudo cargar cairo. Instala lua-lgi: sudo pacman -S lua-lgi")
    return
end

-- Configuración de barras
bars_settings = {
    {
        -- CPU Bar
        name='cpu',
        arg='cpu0',
        max=100,
        x=50,
        y=120,
        width=200,
        height=20,
        bg_colour=0x1e1e2e,
        bg_alpha=0.6,
        fg_colour=0x89b4fa,
        fg_alpha=0.9,
        border_colour=0x89b4fa,
        border_alpha=0.5,
    },
    {
        -- RAM Bar
        name='memperc',
        arg='',
        max=100,
        x=50,
        y=200,
        width=200,
        height=20,
        bg_colour=0x1e1e2e,
        bg_alpha=0.6,
        fg_colour=0xa6e3a1,
        fg_alpha=0.9,
        border_colour=0xa6e3a1,
        border_alpha=0.5,
    },
    {
        -- Disk Bar
        name='fs_used_perc',
        arg='/',
        max=100,
        x=50,
        y=280,
        width=200,
        height=20,
        bg_colour=0x1e1e2e,
        bg_alpha=0.6,
        fg_colour=0xf38ba8,
        fg_alpha=0.9,
        border_colour=0xf38ba8,
        border_alpha=0.5,
    },
    {
        -- Download Bar
        name='downspeedf',
        arg='wlan0',
        max=100,
        x=50,
        y=360,
        width=200,
        height=20,
        bg_colour=0x1e1e2e,
        bg_alpha=0.6,
        fg_colour=0xf9e2af,
        fg_alpha=0.9,
        border_colour=0xf9e2af,
        border_alpha=0.5,
    },
}

function rgb_to_r_g_b(colour, alpha)
    return ((colour / 0x10000) % 0x100) / 255., 
           ((colour / 0x100) % 0x100) / 255., 
           (colour % 0x100) / 255., 
           alpha
end

function draw_bar(cr, value, pt)
    local x = pt['x']
    local y = pt['y']
    local w = pt['width']
    local h = pt['height']
    local pct = value / pt['max']
    
    -- Background con borde redondeado
    cairo_set_line_width(cr, 0)
    cairo_rectangle(cr, x, y, w, h)
    cairo_set_source_rgba(cr, rgb_to_r_g_b(pt['bg_colour'], pt['bg_alpha']))
    cairo_fill(cr)
    
    -- Borde
    cairo_rectangle(cr, x, y, w, h)
    cairo_set_source_rgba(cr, rgb_to_r_g_b(pt['border_colour'], pt['border_alpha']))
    cairo_set_line_width(cr, 2)
    cairo_stroke(cr)
    
    -- Barra de progreso con glow
    if pct > 0 then
        local bar_width = w * pct
        
        -- Glow exterior
        cairo_rectangle(cr, x - 2, y - 2, bar_width + 4, h + 4)
        cairo_set_source_rgba(cr, rgb_to_r_g_b(pt['fg_colour'], pt['fg_alpha'] * 0.3))
        cairo_fill(cr)
        
        -- Barra principal
        cairo_rectangle(cr, x, y, bar_width, h)
        cairo_set_source_rgba(cr, rgb_to_r_g_b(pt['fg_colour'], pt['fg_alpha']))
        cairo_fill(cr)
        
        -- Highlight superior
        local gradient = cairo_pattern_create_linear(x, y, x, y + h)
        cairo_pattern_add_color_stop_rgba(gradient, 0, rgb_to_r_g_b(0xffffff, 0.4))
        cairo_pattern_add_color_stop_rgba(gradient, 1, rgb_to_r_g_b(0xffffff, 0.0))
        cairo_rectangle(cr, x, y, bar_width, h / 2)
        cairo_set_source(cr, gradient)
        cairo_fill(cr)
        cairo_pattern_destroy(gradient)
    end
end

function conky_bars()
    if conky_window == nil then return end
    
    local cs = cairo_xlib_surface_create(
        conky_window.display,
        conky_window.drawable,
        conky_window.visual,
        conky_window.width,
        conky_window.height
    )
    
    local cr = cairo_create(cs)
    
    local updates = tonumber(conky_parse('${updates}'))
    
    if updates > 5 then
        for i, setting in pairs(bars_settings) do
            local str = string.format('${%s %s}', setting['name'], setting['arg'])
            local value = tonumber(conky_parse(str)) or 0
            draw_bar(cr, value, setting)
        end
    end
    
    cairo_destroy(cr)
    cairo_surface_destroy(cs)
end