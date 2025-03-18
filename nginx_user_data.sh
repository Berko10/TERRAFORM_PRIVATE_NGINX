              #!/bin/bash
              הסרת תווי /r
              sudo sed -i 's/\r//g' /var/lib/cloud/instance/user-data.txt

              # עדכון המערכת והתקנת dos2unix
              sudo apt-get update -y
              sudo apt install dos2unix -y

              # המרה של תו ה-CRLF ל-LF בלבד
              sudo dos2unix /var/lib/cloud/instance/user-data.txt

              # עדכון המערכת והתקנת Docker
              sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common

              # הוספת מפתח ציבורי לדומיין של Docker
              curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo tee /etc/apt/trusted.gpg.d/docker.asc

              # הוספת מאגר Docker
              sudo add-apt-repository "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/docker.asc] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

              # עדכון מאגרי המערכת והתקנת Docker
              sudo apt-get update -y
              sudo apt-get install -y docker.io

              # התחלת Docker כך שיתחיל אוטומטית
              sudo systemctl start docker
              sudo systemctl enable docker

              # יצירת קובץ index.html
              echo 'yo this is nginx' > index.html

              # הרצת Docker עם Nginx
              docker run -d -p 80:80 -v $(pwd)/index.html:/usr/share/nginx/html/index.html nginx