# esklyarenkoDS_microservices
esklyarenkoDS microservices repository

Домашняя работа №14

- Установили docker, docker-compose, docker-machine
- Запустили первый контейнер,посмотрели ралзличные команды (run, ps, start exec и т.п.)
- Сохранили вывод команды docker images в файл dockermonolith/docker-1.log
- *Сравнили вывод команд docker inspect <u_container_id> и docker inspect <u_image_id> и записали в файл docker-1.logdocker-1.log
- Исследовали различные команды такие как system df, rm, rmi
- Инициализировали YC, создали инстанс, инициализирвоали на нем докер хост систему docker-machine
- Собрали образ с приложением с помощью файлов Dockerfile, db_config, start.sh, mongod.conf
- Запустили контейнер, проверили результат работы приложения\БД
- Зарегистрировались на Docker hub и запушили туда image
- С помощью дополнительных команд исследовали информацию об образе, логи контейнера, посмотрели процессы и т.п.

