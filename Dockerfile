FROM python:3.9-slim

# create workdir, install dependencies
WORKDIR /app
RUN useradd --uid 1000 theia && chown -R theia /app
COPY --chown=theia:theia requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# copy and run the app
COPY --chown=theia:theia service/ ./service/
USER theia
EXPOSE 8080
CMD ["gunicorn","--bind=0.0.0.0:8080","--log-level=info", "service:app"]