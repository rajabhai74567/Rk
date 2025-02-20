# Flutter Docker Image यूज़ कर रहे हैं
FROM cirrusci/flutter:stable

# सिस्टम अपडेट + ज़रूरी पैकेज इंस्टॉल
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    git \
    libglu1-mesa \
    python3 \
    python3-pip

# Flutter का PATH सेट करना
ENV PATH="$PATH:/usr/local/flutter/bin"

# Firebase CLI इंस्टॉल (अगर चाहिए)
RUN curl -sL https://firebase.tools | bash

# वर्किंग डायरेक्टरी सेट करना
WORKDIR /app

# सभी फाइलें कॉपी करना
COPY . .

# Debugging: देखो pubspec.yaml सही जगह कॉपी हुआ कि नहीं
RUN ls -la /app

# Flutter डिपेंडेंसी क्लीन और इंस्टॉल
RUN flutter clean
RUN flutter pub get

# Python dependencies इंस्टॉल
RUN pip3 install -r requirements.txt || echo "No requirements.txt found"

# सभी फाइलों को executable बनाना
RUN chmod +x *

# Python Script रन करना
CMD ["python3", "d.py"]
