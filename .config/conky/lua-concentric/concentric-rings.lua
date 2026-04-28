--[[
Rings concéntricos con efectos de partículas
~/.config/conky/lua-concentric/concentric-rings.lua
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

-- Anillos concéntricos
concentric_rings = {
    {
        name='cpu',
        arg='cpu0',
        max=100,
        x=150,
        y=150,
        radius=100,
        thickness=8,
        start_angle=0,
        end_angle=360,
        colour=0x89b4fa,
        alpha=0.9,
    },
    {
        name='memperc',
        arg='',
        max=100,
        x=150,
        y=150,
        radius=120,
        thickness=8,
        start_angle=0,
        end_angle=360,
        colour=0xa6e3a1,
        alpha=0.9,
    },
    {
        name='fs_used_perc',
        arg='/',
        max=100,
        x=150,
        y=150,
        radius=140,
        thickness=8,
        start_angle=0,
        end_angle=360,
        colour=0xf38ba8,
        alpha=0.9,
    },
    {
        name='downspeedf',
        arg='wlan0',
        max=100,
        x=150,
        y=150,
        radius=160,
        thickness=8,
        start_angle=0,
        end_angle=360,
        colour=0xf9e2af,
        alpha=0.9,
    },
}

function rgb_to_r_g_b(colour, alpha)
    return ((colour / 0x10000) % 0x100) / 255.,
           ((colour / 0x100) % 0x100) / 255.,
           (colour % 0x100) / 255.,
           alpha
end

function draw_concentric_ring(cr, value, pt)
    local xc = pt['x']
    local yc = pt['y']
    local radius = pt['radius']
    local thickness = pt['thickness']
    local pct = value / pt['max']
    
    local start_angle = pt['start_angle'] * (math.pi / 180) - (math.pi / 2)
    local end_angle = pt['end_angle'] * (math.pi / 180) - (math.pi / 2)
    local angle_range = end_angle - start_angle
    local current_angle = start_angle + (angle_range * pct)
    
    -- Background ring
    cairo_set_line_width(cr, thickness)
    cairo_set_line_cap(cr, CAIRO_LINE_CAP_ROUND)
    cairo_arc(cr, xc, yc, radius, start_angle, end_angle)
    cairo_set_source_rgba(cr, rgb_to_r_g_b(0x1e1e2e, 0.4))
    cairo_stroke(cr)
    
    if pct > 0 then
        -- Glow externo
        cairo_set_line_width(cr, thickness + 6)
        cairo_arc(cr, xc, yc, radius, start_angle, current_angle)
        cairo_set_source_rgba(cr, rgb_to_r_g_b(pt['colour'], pt['alpha'] * 0.2))
        cairo_stroke(cr)
        
        -- Ring principal
        cairo_set_line_width(cr, thickness)
        cairo_arc(cr, xc, yc, radius, start_angle, current_angle)
        cairo_set_source_rgba(cr, rgb_to_r_g_b(pt['colour'], pt['alpha']))
        cairo_stroke(cr)
        
        -- Punto brillante al final
        local end_x = xc + radius * math.cos(current_angle)
        local end_y = yc + radius * math.sin(current_angle)
        
        -- Gradiente radial para el punto
        local gradient = cairo_pattern_create_radial(end_x, end_y, 0, end_x, end_y, thickness)
        cairo_pattern_add_color_stop_rgba(gradient, 0, rgb_to_r_g_b(0xffffff, 1.0))
        cairo_pattern_add_color_stop_rgba(gradient, 0.5, rgb_to_r_g_b(pt['colour'], pt['alpha']))
        cairo_pattern_add_color_stop_rgba(gradient, 1, rgb_to_r_g_b(pt['colour'], 0.0))
        
        cairo_arc(cr, end_x, end_y, thickness, 0, 2 * math.pi)
        cairo_set_source(cr, gradient)
        cairo_fill(cr)
        cairo_pattern_destroy(gradient)
    end
end

function conky_concentric()
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
        for i, ring in pairs(concentric_rings) do
            local str = string.format('${%s %s}', ring['name'], ring['arg'])
            local value = tonumber(conky_parse(str)) or 0
            draw_concentric_ring(cr, value, ring)
        end
    end
    
    cairo_destroy(cr)
    cairo_surface_destroy(cs)
end