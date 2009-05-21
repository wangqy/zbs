#这里放置系统所有的配置信息,注意,可配置项越少越好
#呼叫中心服务器地址
#CALL_CENTER = "192.168.1.7"
CALL_CENTER = "www.mixcall.cn"
#录音文件存放路径路径(最后不要加斜杠)
WAV_FILE_PATH = "/var/spool/asterisk/monitor"
HTTP_WAV_FILE_PATH = "http://#{CALL_CENTER}/monitor/misc/audio.php?recording=#{WAV_FILE_PATH}"
