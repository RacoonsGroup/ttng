Task Tracker next generation
====================

# Перенос данных со страрого TT

* Выполнить pg_dump на production
* Выполнить pg_restore - на локальной копии старого TT. pg_restore -h localhost -U postgresuser -d timetrack_development ~/name.dump
* Установить gem 'yaml_db' на локальной копии старого TT. Выполнить rake db:data:dump   ->   Dump contents of Rails database to db/data.yml
* Из файла data.yml удалить разделители "---"
* RAILS_ENV=production bundle exec rake old_tt:migrate_old_tt
* Пользователи импортируются с позицией nobody - выставить после импорта
*