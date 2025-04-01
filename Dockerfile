# --- Build stage ---
    FROM cirrusci/flutter:stable AS builder

    WORKDIR /app
    COPY . .
    
    RUN flutter pub get
    RUN flutter build web
    
    # --- Serve stage (static) ---
    FROM nginx:alpine
    
    COPY --from=builder /app/build/web /usr/share/nginx/html
    EXPOSE 80
    CMD ["nginx", "-g", "daemon off;"]
    