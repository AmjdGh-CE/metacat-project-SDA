FROM openjdk:17-jdk-slim

# Add non-root user
RUN useradd -m -u 1001 metacatuser

# Install required packages (if needed)
RUN apt-get update && apt-get install -y \
    curl \
    openssl \
    && rm -rf /var/lib/apt/lists/*

# Setup working directory
WORKDIR /app

# Copy metacat WAR and config
COPY ./metacat.war ./metacat.war
COPY ./config /app/config

# Change ownership
RUN chown -R metacatuser:metacatuser /app

# Switch to non-root user
USER metacatuser

# Expose secure port
EXPOSE 8443

CMD ["java", "-jar", "metacat.war"]
