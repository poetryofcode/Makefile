 ✅ make build-back собирается без ошибок.
 ✅ make build-front собирается без ошибок.
 ✅ make network создаёт сеть todo-net.
 ✅ make up-db запускает контейнер todo-db-container (проверяется docker ps).
 ✅make up-back запускает todo-back-container и в его логах нет ошибок подключения к БД.
 ✅ make up-front запускает todo-front-container.
 ✅ В браузере открывается http://localhost:18080 — фронт грузится.
 ✅ В DevTools (вкладка Network) видно, что фронт делает запросы на http://localhost:13000 и получает ответ без CORS-ошибок.
 ✅ Создание/чтение TODO-записей работает end-to-end (данные доходят до Postgres).
 ✅ make e2e-install отработал без ошибок (один раз).
 ✅ make e2e отрабатывает без падений и все тесты зелёные.
 ✅ make down-front, make down-back, make down-db, make network-rm корректно всё гасят и удаляют.
 ✅ Все три заполненных значения в env-файлах сопровождены коротким объяснением почему именно так.
