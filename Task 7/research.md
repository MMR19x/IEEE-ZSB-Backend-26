# Research: Web Development Fundamentals

## 1. GET vs. POST: Method Differences
In the HTML `<form>` tag, the `method` attribute determines how data is transmitted to the server.

* **GET Method**:
    * **Functionality**: Appends form data into the URL in name/value pairs (e.g., `register.html?fullname=Peter`).
    * **Security**: **Low security**. Data remains visible in the browser address bar, browser history, and server logs.
    * **Capacity**: Limited by the maximum length of a URL (usually around 2048 characters).
* **POST Method**:
    * **Functionality**: Sends data within the HTTP message body, meaning it does not appear in the URL.
    * **Security**: **Higher security**. Sensitive data is not exposed in the URL or history.
    * **Capacity**: No technical limit on data size, making it suitable for large inputs or file uploads.


**Which to use for `register.html`?**
You must use **`method="POST"`**. Since registration involves sensitive information like passwords, using `GET` would expose that data in plain text in the browser's address bar, creating a significant security risk.

---

## 2. Semantic HTML: Beyond the `<div>`
While a website can technically be built using only `<div>` tags, using semantic tags like `<header>`, `<main>`, `<section>`, and `<footer>` is superior for the following reasons:

* **Accessibility**: Screen readers use these tags as landmarks, allowing visually impaired users to skip directly to the main content or navigation.
* **SEO (Search Engine Optimization)**: Search engines prioritize content within semantic tags to better understand the page structure and relevance.
* **Maintainability**: It makes the code more readable for developers, as the tags clearly define the purpose of each block of content.
* **Browser Features**: Extensions like "Reader Mode" rely on these tags to strip away clutter and display the primary content clearly.


---

## 3. The Request/Response Cycle
When you type `google.com` and hit Enter, the browser follows these steps to fetch the page:

1.  **DNS Lookup**: The browser contacts a **DNS (Domain Name System)** server to translate the human-readable domain `google.com` into a machine-readable **IP Address**.
2.  **Establish Connection**: The browser establishes a TCP connection with the server at that specific IP address.
3.  **HTTP Request**: The browser sends an **HTTP Request** (usually a `GET` request) to the server asking for the page content.
4.  **Server Response**: The server processes the request and sends back an **HTTP Response** containing the status code (e.g., `200 OK`) and the HTML/CSS files.
5.  **Rendering**: The browser receives the files and renders the website on your screen.
