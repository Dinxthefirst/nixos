monitor = DP-1, 2560x1440@165.00, 0x0, 1
monitor = HDMI-A-1, 1920x1080@60, 2560x360, 1

hl.monitor({
  output = "DP-1",
  mode = "2560x1440@165.00",
  position = "0x0",
  scale = 1,
})

hl.monitor({
  output = "HDMI-A-1"
  mode = "1920x1080@60",
  position = "2560x360",
  scale = 1,
})