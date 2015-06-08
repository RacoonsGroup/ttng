Task Tracker next generation
====================

# Перенос данных со старого TT

* Выполнить pg_dump на production - pg_dump -Fc -U tasktrack -W -h localhost tasktrack > tasktrack_bd6.dump
* Выполнить pg_restore - на локальной копии старого TT. pg_restore -h localhost -U postgresuser -d timetrack_development ~/name.dump
* Установить gem 'yaml_db' на локальной копии старого TT. Выполнить rake db:data:dump   ->   Dump contents of Rails database to db/data.yml
* Из файла data.yml удалить разделители "---"
* RAILS_ENV=production bundle exec rake old_tt:migrate_old_tt
* Пользователи импортируются с позицией nobody - выставить после импорта
*

# PG::DatetimeFieldOverflow: ERROR:  date/time field value out of range

* ALTER DATABASE ttng_production SET datestyle TO "ISO, DMY";

# Список email оповещений

* Создание/редактирование проекта
* Добавление к проекту комментариев с опцией "оповестить сотрудников по email"

* Оповещения о ДР за неделю для HR
* Оповещения о аттестации через два месяца по приему на работу и каждые 6 месяцев после приема на работу для HR