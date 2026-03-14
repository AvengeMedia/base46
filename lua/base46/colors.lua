-- The MIT License (MIT)
--
-- Copyright (c) 2022 Leon Heidelbach
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

-- All credits to https://github.com/LeonHeidelbach for making this!
-- 90% of functions are written by him

local M = {}

---@param x number
---@return integer
local function signum(x)
  if x < 0 then
    return -1
  elseif x == 0 then
    return 0
  else
    return 1
  end
end

---Convert a hex color value to RGB
---@param hex string The hex color value
---@return number? r Red (0-255)
---@return number? g Green (0-255)
---@return number? b Blue (0-255)
M.hex2rgb = function(hex)
  local hash = string.sub(hex, 1, 1) == "#"
  if string.len(hex) ~= (7 - (hash and 0 or 1)) then
    return
  end

  local r = tonumber(hex:sub(2 - (hash and 0 or 1), 3 - (hash and 0 or 1)), 16)
  local g = tonumber(hex:sub(4 - (hash and 0 or 1), 5 - (hash and 0 or 1)), 16)
  local b = tonumber(hex:sub(6 - (hash and 0 or 1), 7 - (hash and 0 or 1)), 16)
  return r, g, b
end

---Convert a hex color value to RGB ratio
---@param hex string The hex color value
---@return number r Red (0-100)
---@return number g Green (0-100)
---@return number b Blue (0-100)
M.hex2rgb_ratio = function(hex)
  local r, g, b = M.hex2rgb(hex)
  return math.floor(r / 255 * 100), math.floor(g / 255 * 100), math.floor(b / 255 * 100)
end

---Convert an RGB color value to hex
---@param r number Red (0-255)
---@param g number Green (0-255)
---@param b number Blue (0-255)
---@return string The hexadecimal string representation of the color
M.rgb2hex = function(r, g, b)
  return string.format("#%02x%02x%02x", math.floor(r), math.floor(g), math.floor(b))
end

---Helper function to convert a HSL color value to RGB
---Not to be used directly, use M.hsl2rgb instead
---@param p number
---@param q number
---@param a number
---@return number
M.hsl2rgb_helper = function(p, q, a)
  if a < 0 then
    a = a + 6
  end
  if a >= 6 then
    a = a - 6
  end
  if a < 1 then
    return (q - p) * a + p
  elseif a < 3 then
    return q
  elseif a < 4 then
    return (q - p) * (4 - a) + p
  else
    return p
  end
end

---Convert a HSL color value to RGB
---@param h number Hue (0-360)
---@param s number Saturation (0-1)
---@param l number Lightness (0-1)
---@return number r Red (0-255)
---@return number g Green (0-255)
---@return number b Blue (0-255)
M.hsl2rgb = function(h, s, l)
  local t1, t2, r, g, b

  h = h / 60
  if l <= 0.5 then
    t2 = l * (s + 1)
  else
    t2 = l + s - (l * s)
  end

  t1 = l * 2 - t2
  r = M.hsl2rgb_helper(t1, t2, h + 2) * 255
  g = M.hsl2rgb_helper(t1, t2, h) * 255
  b = M.hsl2rgb_helper(t1, t2, h - 2) * 255

  return r, g, b
end

---Convert an RGB color value to HSL
---@param r number Red (0-255)
---@param g number Green (0-255)
---@param b number Blue (0-255)
---@return number h Hue (0-360)
---@return number s Saturation (0-1)
---@return number l Lightness (0-1)
M.rgb2hsl = function(r, g, b)
  local min, max, l, s, maxcolor, h
  r, g, b = r / 255, g / 255, b / 255

  min = math.min(r, g, b)
  max = math.max(r, g, b)
  maxcolor = 1 + (max == b and 2 or (max == g and 1 or 0))

  if maxcolor == 1 then
    h = (g - b) / (max - min)
  elseif maxcolor == 2 then
    h = 2 + (b - r) / (max - min)
  elseif maxcolor == 3 then
    h = 4 + (r - g) / (max - min)
  end

  if not rawequal(type(h), "number") then
    h = 0
  end

  h = h * 60

  if h < 0 then
    h = h + 360
  end

  l = (min + max) / 2

  if min == max then
    s = 0
  else
    if l < 0.5 then
      s = (max - min) / (max + min)
    else
      s = (max - min) / (2 - max - min)
    end
  end

  return h, s, l
end

---Convert a hex color value to HSL
---@param hex string The hex color value
---@return number? h Hue (0-360)
---@return number? s Saturation (0-1)
---@return number? l Lightness (0-1)
M.hex2hsl = function(hex)
  local r, g, b = M.hex2rgb(hex)
  if not r or not g or not b then
    return
  end
  return M.rgb2hsl(r, g, b)
end

---Convert a HSL color value to hex
---@param h number Hue (0-360)
---@param s number Saturation (0-1)
---@param l number Lightness (0-1)
---@return string hex hex color value
M.hsl2hex = function(h, s, l)
  local r, g, b = M.hsl2rgb(h, s, l)
  return M.rgb2hex(r, g, b)
end

---Convert a XYZ color value to RGB
---XYZ is a color space defined by the CIE (International Commission on Illumination) in 1931.
---It represents all colors visible to the human eye and serves as a reference for other color spaces.
---  - X: Represents a mix of cone responses (roughly red)
---  - Y: Represents luminance (brightness)
---  - Z: Represents a mix of cone responses (roughly blue)
---@param x number X component (0-1)
---@param y number Y component (0-1)
---@param z number Z component (0-1)
---@return number r Red component (0-255)
---@return number g Green component (0-255)
---@return number b Blue component (0-255)
M.xyz2rgb = function(x, y, z)
  local r, g, b =
    3.240969941904523 * x - 1.537383177570094 * y - 0.498610760293003 * z,
    -0.969243636280880 * x + 1.875967501507721 * y + 0.041555057407176 * z,
    0.055630079696994 * x - 0.203976958888977 * y + 1.056971514242879 * z

  r, g, b = math.min(math.max(r, 0.0), 1.0), math.min(math.max(g, 0.0), 1.0), math.min(math.max(b, 0.0), 1.0)

  return math.floor(r * 255 + 0.5), math.floor(g * 255 + 0.5), math.floor(b * 255 + 0.5)
end

---Convert a RGB color value to XYZ
---XYZ is a color space defined by the CIE (International Commission on Illumination) in 1931.
---It represents all colors visible to the human eye and serves as a reference for other color spaces.
---  - X: Represents a mix of cone responses (roughly red)
---  - Y: Represents luminance (brightness)
---  - Z: Represents a mix of cone responses (roughly blue)
---@param r number Red component (0-255)
---@param g number Green component (0-255)
---@param b number Blue component (0-255)
---@return number x X component (0-1)
---@return number y Y component (0-1)
---@return number z Z component (0-1)
M.rgb2xyz = function(r, g, b)
  r, g, b = r / 255, g / 255, b / 255
  return 0.412390799265959 * r + 0.357584339383878 * g + 0.180480788401834 * b,
    0.212639005871510 * r + 0.715168678767756 * g + 0.072192315360734 * b,
    0.019330818715592 * r + 0.119194779794626 * g + 0.950532152249661 * b
end

---Convert a JCH color value to XYZ with default viewing conditions as per material 3 design
---JCH (JzCzHz) is a perceptually uniform color space derived from CIECAM02, where:
---  - J: Lightness (0-100)
---  - C: Chroma (color intensity)
---  - H: Hue (0-360 degrees)
---This space is designed to better align with human color perception compared to RGB or HSL.
---@param j number Lightness (0-100)
---@param c number Chroma (color intensity)
---@param h number Hue in degrees (0-360)
---@return number x XYZ X component
---@return number y XYZ Y component
---@return number z XYZ Z component
M.jch2xyz = function(j, c, h)
  local alpha
  if c == 0.0 or j == 0.0 then
    alpha = 0.0
  else
    alpha = (c / math.sqrt(j / 100.0))
  end

  local t = (alpha / 0.8834525670408592) ^ (1.0 / 0.9)
  local hRad = h * math.pi / 180.0
  local eHue = 0.25 * (math.cos(hRad + 2.0) + 3.8)
  local ac = 29.98099719444734 * ((j / 100.0) ^ 0.759112960023724)
  local p1 = eHue * 3911.227617099522
  local p2 = ac / 1.0169191804458757
  local hSin = math.sin(hRad)
  local hCos = math.cos(hRad)
  local gamma = 23.0 * (p2 + 0.305) * t / (23.0 * p1 + 11 * t * hCos + 108.0 * t * hSin)
  local a = gamma * hCos
  local b = gamma * hSin

  local rA = (460.0 * p2 + 451.0 * a + 288.0 * b) / 1403.0
  local gA = (460.0 * p2 - 891.0 * a - 261.0 * b) / 1403.0
  local bA = (460.0 * p2 - 220.0 * a - 6300.0 * b) / 1403.0

  local rCBase = math.max(0, 27.13 * math.abs(rA) / (400.0 - math.abs(rA)))
  local rC = signum(rA) / 0.003884814537800353 * (rCBase ^ (1.0 / 0.42))
  local gCBase = math.max(0, 27.13 * math.abs(gA) / (400.0 - math.abs(gA)))
  local gC = signum(gA) / 0.003884814537800353 * (gCBase ^ (1.0 / 0.42))
  local bCBase = math.max(0, 27.13 * math.abs(bA) / (400.0 - math.abs(bA)))
  local bC = signum(bA) / 0.003884814537800353 * (bCBase ^ (1.0 / 0.42))

  local rF = rC / 1.02117770275752
  local gF = gC / 0.9863077294280124
  local bF = bC / 0.9339605082802299

  local x = 1.86206786 * rF - 1.01125463 * gF + 0.14918677 * bF
  local y = 0.38752654 * rF + 0.62144744 * gF - 0.00897398 * bF
  local z = -0.01584150 * rF - 0.03412294 * gF + 1.04996444 * bF

  return x, y, z
end

---Convert a XYZ color value to JCH with default viewing conditions as per material 3 design
---JCH (JzCzHz) is a perceptually uniform color space derived from CIECAM02, where:
---  - J: Lightness (0-100)
---  - C: Chroma (color intensity)
---  - H: Hue (0-360 degrees)
---This space is designed to better align with human color perception compared to RGB or HSL.
---@param x number XYZ X component
---@param y number XYZ Y component
---@param z number XYZ Z component
---@return number j Lightness (0-100)
---@return number c Chroma (color intensity)
---@return number h Hue in degrees (0-360)
M.xyz2jch = function(x, y, z)
  local rC = 0.401288 * x + 0.650173 * y - 0.051461 * z
  local gC = -0.250268 * x + 1.204414 * y + 0.045854 * z
  local bC = -0.002079 * x + 0.048952 * y + 0.953127 * z

  local rD = 1.02117770275752 * rC
  local gD = 0.9863077294280124 * gC
  local bD = 0.9339605082802299 * bC

  local rAF = (0.003884814537800353 * math.abs(rD)) ^ 0.42
  local gAF = (0.003884814537800353 * math.abs(gD)) ^ 0.42
  local bAF = (0.003884814537800353 * math.abs(bD)) ^ 0.42

  local rA = signum(rD) * 400.0 * rAF / (rAF + 27.13)
  local gA = signum(gD) * 400.0 * gAF / (gAF + 27.13)
  local bA = signum(bD) * 400.0 * bAF / (bAF + 27.13)

  local a = (11.0 * rA - 12.0 * gA + bA) / 11.0
  local b = (rA + gA - 2.0 * bA) / 9.0
  local u = (20.0 * rA + 20.0 * gA + 21.0 * bA) / 20.0
  local p2 = (40.0 * rA + 20.0 * gA + bA) / 20.0

  local atan2 = math.atan2(b, a)
  local atanDegrees = atan2 * 180.0 / math.pi
  local h = atanDegrees % 360

  local ac = p2 * 1.0169191804458757

  local j = 100.0 * ((ac / 29.98099719444734) ^ 1.3173270022537198)

  local huePrime
  if h < 20.14 then
    huePrime = (h + 360)
  else
    huePrime = h
  end
  local eHue = 0.25 * (math.cos(huePrime * math.pi / 180.0 + 2.0) + 3.8)
  local p1 = eHue * 3911.227617099522
  local t = p1 * math.sqrt(a * a + b * b) / (u + 0.305)
  local alpha = (t ^ 0.9) * 0.8834525670408592
  local c = alpha * math.sqrt(j / 100.0)

  return j, c, h
end

---Convert a hex color value to JCH with default viewing conditions as per material 3 design
---@param hex string
---@return number? j
---@return number? c
---@return number? h
M.hex2jch = function(hex)
  local r, g, b = M.hex2rgb(hex)
  if not r or not g or not b then
    return
  end
  local x, y, z = M.rgb2xyz(r, g, b)
  return M.xyz2jch(x, y, z)
end

---Convert a JCH color value to hex with default viewing conditions as per material 3 design
---@param j number
---@param c number
---@param h number
---@return string hex
M.jch2hex = function(j, c, h)
  local x, y, z = M.jch2xyz(j, c, h)
  local r, g, b = M.xyz2rgb(x, y, z)
  return M.rgb2hex(r, g, b)
end

---Hue harominzation of a design color towards a source color. This uses the CIECAM02 JCH colorspace
---instead of HSL: J holds the role of lightness, C that of chroma (somewhat related to saturation) and
---H that of hue. This space is supposedly perceptually much more accurate than HSL and is better suited
---for such manipulations.
---@param design_color string Hex string
---@param source_color string Hex string
---@param harmony number (0 - 1) How much `design_color` must be shifted towards `source_color`
---@param threshold number (0 - 180) Maximum authorized hue shift, in degrees
---@return string? hex nil if one of the input hex strings is incorrect
M.harmonize = function(design_color, source_color, harmony, threshold)
  local j, c, from_h = M.hex2jch(design_color)
  local _, _, to_h = M.hex2jch(source_color)
  if not j or not c or not from_h or not to_h then
    return
  end

  local diff_degrees = 180.0 - math.abs(math.abs(to_h - from_h) - 180.0)
  local rot_degrees = math.min(diff_degrees * harmony, threshold)

  local rotate_dir
  if (to_h - from_h) % 360.0 < 180.0 then
    rotate_dir = 1.0
  else
    rotate_dir = -1.0
  end

  local new_hue = (rot_degrees * rotate_dir + from_h) % 360.0
  return M.jch2hex(j, c, new_hue)
end

---Change the hue of a color by a given amount
---@param hex string The hex color value
---@param percent number The amount to change the hue. Negative values decrease the hue, positive values increase it.
---@return string? hex The hex color value
M.change_hex_hue = function(hex, percent)
  local h, s, l = M.hex2hsl(hex)
  if not h or not s or not l then
    return
  end
  -- Convert percentage to a degree shift
  local shift = (percent / 100) * 360
  h = (h + shift) % 360
  if h < 0 then
    h = h + 360
  end
  return M.hsl2hex(h, s, l)
end

---Desaturate or saturate a color by a given percentage
---@param hex string The hex color value
---@param percent number The percentage to desaturate or saturate the color. Negative values desaturate the color, positive values saturate it
---@return string? hex The hex color value
M.change_hex_saturation = function(hex, percent)
  local h, s, l = M.hex2hsl(hex)
  if not h or not s or not l then
    return
  end
  s = s + (percent / 100)
  if s > 1 then
    s = 1
  end
  if s < 0 then
    s = 0
  end
  return M.hsl2hex(h, s, l)
end

---Lighten or darken a color by a given percentage
---@param hex string The hex color value
---@param percent number The percentage to lighten or darken the color. Negative values darken the color, positive values lighten it
---@return string? hex The hex color value
M.change_hex_lightness = function(hex, percent)
  local h, s, l = M.hex2hsl(hex)
  if not h or not s or not l then
    return
  end
  l = l + (percent / 100)
  if l > 1 then
    l = 1
  end
  if l < 0 then
    l = 0
  end
  return M.hsl2hex(h, s, l)
end

---Compute a gradient between two colors
---@param hex1 string The first hex color value
---@param hex2 string The second hex color value
---@param steps number The number of steps to compute
---@return string[] gradient A table of hex color values
M.compute_gradient = function(hex1, hex2, steps)
  local h1, s1, l1 = M.hex2hsl(hex1)
  local h2, s2, l2 = M.hex2hsl(hex2)
  if not h1 or not s1 or not l1 or not h2 or not s2 or not l2 then
    return {}
  end
  local h, s, l
  local h_step = (h2 - h1) / (steps - 1)
  local s_step = (s2 - s1) / (steps - 1)
  local l_step = (l2 - l1) / (steps - 1)
  local gradient = {}

  for i = 0, steps - 1 do
    h = h1 + (h_step * i)
    s = s1 + (s_step * i)
    l = l1 + (l_step * i)
    gradient[i + 1] = M.hsl2hex(h, s, l)
  end

  return gradient
end

---Generate complementary colors
---@param hex string The hex color value
---@param count number The number of complementary colors to generate
---@return string[] # A table containing the complementary colors in hex format
M.hex2complementary = function(hex, count)
  local h, s, l = M.hex2hsl(hex)
  if not h or not s or not l then
    return {}
  end
  local complementary_colors = {}

  -- Calculate the hue for the complementary color (180 degrees shift)
  local complementary_hue = (h + 180) % 360

  -- Create a gradient of colors by slightly varying the complementary hue
  local hue_step = 360 / count
  for i = 0, count - 1 do
    local new_hue = (complementary_hue + (hue_step * i)) % 360
    local complementary_hex = M.hsl2hex(new_hue, s, l)
    table.insert(complementary_colors, complementary_hex)
  end

  return complementary_colors
end

---Mix two colors with a given percentage.
---@param first string The primary hex color.
---@param second string The hex color you want to mix into the first color.
---@param strength number The percentage of second color in the output. This needs to be a number between 0 - 100.
---@return string mixed The mixed color as a hex value
M.mix = function(first, second, strength)
  if strength == nil then
    strength = 0.5
  end

  local s = strength / 100
  local r1, g1, b1 = M.hex2rgb(first)
  local r2, g2, b2 = M.hex2rgb(second)

  if r1 == nil or r2 == nil then
    return first
  end

  if s == 0 then
    return first
  elseif s == 1 then
    return second
  end

  local r3 = r1 * (1 - s) + r2 * s
  local g3 = g1 * (1 - s) + g2 * s
  local b3 = b1 * (1 - s) + b2 * s

  return M.rgb2hex(r3, g3, b3)
end

return M
