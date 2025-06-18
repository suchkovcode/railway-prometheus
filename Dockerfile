FROM prom/prometheus:latest

# Копируем конфигурацию Prometheus
COPY prometheus.yml /etc/prometheus/prometheus.yml

# Создаем директории для данных
USER root
RUN mkdir -p /prometheus

# Возвращаемся к пользователю prometheus
USER nobody

# Открываем порт
EXPOSE 9090

# Точка входа и команды запуска
ENTRYPOINT [ "/bin/prometheus" ]
CMD [ "--config.file=/etc/prometheus/prometheus.yml", \
      "--storage.tsdb.path=/prometheus", \
      "--storage.tsdb.retention.time=30d", \
      "--web.console.libraries=/usr/share/prometheus/console_libraries", \
      "--web.console.templates=/usr/share/prometheus/consoles", \
      "--web.enable-lifecycle", \
      "--log.level=info" ]