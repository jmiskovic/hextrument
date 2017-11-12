local interpreting = {}

local sw, sh = love.graphics.getDimensions()
local hexpad = require('hexpad').new(sw / 2, sh / 2, sh / 7.8, 6, 4)

local tiltP = {0,0,0}

function interpreting.load()

end

function interpreting.process(stream)
  -- simple IIR low-pass filtering of tilt
  local a0 = 0.8
  stream.tilt.lp = {}
  for i,v in ipairs(stream.tilt) do
    stream.tilt.lp[i] = stream.tilt[i] * a0 + tiltP[i] * (1 - a0)
    tiltP[i] = stream.tilt[i]
  end

  stream = hexpad:process(stream)

  return stream
end

return interpreting