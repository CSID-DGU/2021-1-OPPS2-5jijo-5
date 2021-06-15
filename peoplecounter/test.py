import pymysql
import pandas as pd
import logging

conn = pymysql.connect(host='database-2.cfhr6dujtqf4.us-east-2.rds.amazonaws.com',
 user='cha970214', password='ckehgus97!', charset='utf8', db='tempset', port=3306) #DB 연결
cur = conn.cursor() #디폴트 커서 생성

#print('rowcount: ', cur.rowcount)


path = "update_data.txt"
f = open(path, 'r')
line = f.readline()
f.close()

tmp = []
tmp2 = []
cnt = 0
num = ""

time_tmp = 0
print(len(line))
for i in range(len(line)):
	test = "insert  into `detail`(`ucode`,`rid`,`dpeople`,`dtemp`,`dtime`) values ('2105129999mms','E102',"


	if line[i] == " ":
		cnt += 1
		tmp.append(int(num))
		num = ""
	num += line[i]
	if cnt%30 == 0 and cnt > 1:
		cnt = 0
		test += str(tmp[-1]) + ",20,'12:00:00');"
		test = test[:len(test)-7] + str(time_tmp) + test[-6:len(test)]
		print(test)
		time_tmp += 1
#		sql = test
		print(test)
		cur.execute(test)
		conn.commit()

conn.close()
