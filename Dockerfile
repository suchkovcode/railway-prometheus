FROM prom/prometheus:latest

# Копируем конфигурацию Prometheus
COPY prometheus.yml /etc/prometheus/prometheus.yml

# Создаем директории для данных и устанавливаем правильные права
USER root
RUN mkdir -p /prometheus && \
    chown -R nobody:nobody /prometheus && \
    chmod -R 755 /prometheus

# Возвращаемся к пользователю nobody
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