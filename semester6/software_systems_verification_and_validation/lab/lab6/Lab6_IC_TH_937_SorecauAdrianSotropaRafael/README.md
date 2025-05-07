# Lab 6

### 1. Testing in General

Testing is a fundamental part of the software development lifecycle, applied throughout the process to ensure that applications function as intended and meet user requirements. It is typically performed at various stages, from individual units of code to the entire integrated system. Testing is useful because it helps identify and fix bugs early, improves software quality, increases reliability, and builds confidence that the application will perform correctly in real-world scenarios. By systematically verifying both the functionality and performance of software, testing reduces the risk of failures and enhances user satisfaction.

---

### 2. Features of the Application

The application developed for my bachelor thesis, called wlad, is an intelligent meditation recommendation system. It features two types of users: admins and regular users. Admins can upload new meditations, including audio, images, and descriptions, while users can browse all available meditations or receive personalized recommendations by describing their current feelings or needs. The system uses AI-powered embeddings and OpenAI’s Whisper for audio transcription, matching user input to the most suitable meditation. The app is cross-platform, with a modern, mysterious purple-black-white theme, and includes screens for browsing meditations, inputting user needs, playing audio, and managing content (admin only).

---

### 3. Testing Techniques to Use

During the development of wlad, a combination of testing techniques should be employed to ensure robustness and reliability. Unit testing is essential for verifying the correctness of individual components, such as the recommendation algorithm or audio playback logic. Integration testing should be used to validate the interactions between modules, such as the connection between the frontend and backend or the embedding and matching process. System testing is necessary to evaluate the application as a whole, ensuring that all features work together seamlessly and meet user expectations. Automated testing, where possible, will help maintain code quality and catch regressions early.

---

### 4. Unit Testing (Main Feature Example: Recommendation System)

For the main feature of personalized meditation recommendations, unit testing would focus on the core logic that matches user input to the most suitable meditation. Tests would verify that, given a specific user input and a set of meditation embeddings, the system correctly identifies and returns the best match. Edge cases, such as empty input, no available meditations, or ambiguous user requests, should also be tested to ensure the recommendation logic handles them gracefully. Mock data can be used to simulate various scenarios and validate the accuracy and reliability of the matching algorithm.

---

### 5. Integration Testing

Integration testing for wlad should focus on the interaction between the frontend Flutter app, the backend Node.js API, and the AI-powered embedding and transcription services. Key modules to test include the process of uploading a meditation (ensuring the audio is correctly transcribed and embedded), fetching recommendations based on user input, and playing the recommended audio. A suitable integration strategy would be incremental integration, where modules are tested together as they are developed, allowing for early detection of interface issues and ensuring smooth communication between components.

---

### 6. System Testing

System testing for wlad should cover end-to-end scenarios that reflect real user workflows. This includes registering and logging in as a user or admin, uploading new meditations, browsing the meditation list, submitting personal input for recommendations, and playing the recommended audio. Scenarios should also test error handling, such as failed uploads, unavailable audio files, or network interruptions. The goal is to ensure that the entire application, as a unified system, meets its functional requirements and provides a seamless, user-friendly experience.
