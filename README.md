# esklyarenkoDS_microservices
esklyarenkoDS microservices repository

Домашнаяя работа №24

- Развернули Prometheus в k8s из helm чарта
- Посмотрели таргеты для сбора метрик
- Запустили приложение reddit из чарта. Сконфигурировали метрики приложений
- Добавили job_name в Prometheus для каждой компоненты приложения
- Установили Grafana из helm чарта.
- Добавили и настроили дашборды для работы в разрезе namespace k8s

Домашняя работа №23

- Установили Helm (в том числе опробовали версиб 2 и 3)
- Сделали ншаблоны манифестов в чарте. Задеплоили
- Установили Gitlab  с помощью чарта.
- Настроили проекты в Gitlab.
- Настроили CI для микросервисов. Задеплоили приложение.

Домашняя работа №22

- Проверили разницу между сервисами типа ClusterIP и NodePort, LoadBalancer.
- Установили Ingress Controller и настроили Ingress вместо LoadBalancer.
- Защитили сервис с помощью TLS и описали Secret в виде манифеста.
- Настроили Network Policy
- Создали PersistentVolume в YC, добавили запрос PersistentVolumeClain для mongo

Домашняя работа №21

- Развернули k8s локально с помощью minikube
- Описали состояние микросервисов в yaml манифестах в kubernetes/reddit
- Развернули кластер в YC. Создали группу узлов.
- Создали в нем dev namespace и задеплоили в него все микросервисы
  kubectl apply -f ./kubernetes/reddit/ -n dev
- Проверить работоспособность можно по адресу http://84.252.129.234:30218

Домашняя работа №20

- Установлен k8s на трех нодах (одна master, две worker) с помощью kubeadm.
  По инструкции https://www.digitalocean.com/community/tutorials/how-to-create-a-kubernetes-cluster-using-kubeadm-on-ubuntu-18-04-ru
- После добавления нод в кластер проверили командой kubectl get nodes состояние
- Успешно применили манифест post-deployment.yml
- Описали установку в ansible, terraform (пока 1 нода)
- Создали директорию reddit для дальнейшего наполнения

Домашняя работа №19

- Обновили код микросервиса и сделали сборку образов с новыми тегами.
- Сделали отдельный docker-compose-logging.yml для логирования.
- Создали конфигурацию fluend и собрали образ с ним.
- Настролили отправку логов во fluentd и проверили как пишутся логи контейнеров.
- В Kibana выполнили настройки, посмотрели логи, попробовали выполнять поиск.
- Сделали фильтры во fluentd для сервса post и посмотрели как отображаются структурированные логи в Kibana.
- Добавили фильтр для ui сервиса.
- Применили несколько grok-шаблонов и посмотрели логи.
- Подключили сервис Zipkin, посмотрели трейсы в его интейрфейсе

Домашняя работа №18

- Создали Docker хост в Yandex Cloud
- Создали docker-compose-monitoring.yml и вынесли в него мониторинг. В docker-compose.yml оставили только приложения.
- Добавили сервис cAdvisor в docker-compose-monitoring.yml и в prometheus.yml чтобы он начал собирать метрики.
- Запустили сервисы и посмотрели интерфейс cAdvisor
- Добавили сервис Grafana в docker-compose-monitoring.yml
- В сервисе Grafana добавили источник данных Prometheus, создали несколько дашбордов, а так же импортировали и экспортировали их. Сохранены в папке grafana/dashboards
- Проверили работу разных метрик, используя функцию rate(), histogram_quantile
- Собрали образ и подключили AlertManager
- Создали свой Incoming Webhook для Slack.
- Сконфигурировали AlertManager и останавливая сервисы проверили работу. Сообщения отправляются в канал #evgeniy_sklyarenko. Алерты так же можно увидеть в веб-интерфейсе на порту 9093.
- Запушили собранные образы:
https://hub.docker.com/repository/docker/esklyarenkods/post
https://hub.docker.com/repository/docker/esklyarenkods/comment
https://hub.docker.com/repository/docker/esklyarenkods/ui
https://hub.docker.com/repository/docker/esklyarenkods/alertmanager
https://hub.docker.com/repository/docker/esklyarenkods/prometheus

Домашняя работа №17

- Подключились к docker-host и запустили готовый образ Prometheus для ознакомления
- Посмотрели интерфейс, метрики, цели.
- Собрали свой образ с Prometheus с конфигурацией для мониторинга наших микросервисов
- Сделали сборку микросервисов и проверили список endpoint-ов
- Проверили метрики рабочих\нерабочих микросервисов в графическом режиме
- Подключили node exporter для сборка метрик хоста.
- Пересоздали сервисы и проверили работу метрик в динамике (в частности load)
- Запушили собранные сервисы на DocekrHub:
  https://hub.docker.com/repository/docker/esklyarenkods/ui
  https://hub.docker.com/repository/docker/esklyarenkods/post
  https://hub.docker.com/repository/docker/esklyarenkods/comment
  https://hub.docker.com/repository/docker/esklyarenkods/prometheus

Домашняя работа №16

- Подключились к docker host  и запустили контейнеры:
  - с none-драйвером
  - с драйвером host
  - с драйвером bridge
- Сравнили вывод ifconfig.
- После запуска несколько раз docker run --network host -d nginx команда вывода контейнеров docker ps показывает, что в данный момент работает только один контейнер nginx. остальные были остановлены
- После создания сети с использованием bridge запустили контейнеры с использованием сетевых алиасов
-  Запустили контейнеры в двух bridge сетях - front_net и back_net. Пришлось поместить контейнеры post и comment  в обе сети, т.к. при инициализации можно подключить к контейнеру только одну сеть (docker network connect <network> <container>)
-  Подключились по ssh к docker-host, установили пакет bridge-utils и посмотрели как выглядит сетевой стек
- Установили docker-compose
- Создали docker-compose.yml с описанием контейнеров и пр.
- Параметризировали docker-compose.yml (порт db, версии контейнеров, польз., путь volume). Все переменные записали в файл .env
- docker-compose сущности получают в название префикс = имя папки, где запускается docker-compose.yaml. Чтобы переопределить их можно поменять имя каталога или прописать необходимое имя в переменную COMPOSE_PROJECT_NAME

Домашняя работа №15

- Подключились к Docker-host и распаковали архив с микросервисами
- Создали докер-файлы для сервиса постов, сервиса комментариев и интерфейса
- Скачали mongo и собрали образы с сервисами
- Создаи сеть для приложения и запустили контейнеры
- Запустили контейнеры с другими алиасами, проверили работоспособность сервиса
- Улучшили и пересобрали сервис ui, чтобы занимал меньше места. Результат 223Мб
  Оформлено в файле Dockerfile.1
- Создали и подключили volume к контейнеру mongo
- Перезапустили контейнеры, написали пост
- Еще раз перезапустили контейнеры и проверили, что пост не удалился

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

