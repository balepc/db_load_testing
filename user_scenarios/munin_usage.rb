1.upto(100) { |i|
  `sudo /usr/bin/munin-cron --force-root`
  sleep(1)
  puts i
}