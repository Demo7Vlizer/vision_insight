<div align="center">
  <img src="https://readme-typing-svg.demolab.com?font=Fira+Code&duration=3000&pause=1000&color=00FFB3&center=true&vCenter=true&width=435&lines=Welcome+to+AI+Vision+App+🔍;Powered+by+OpenAI's+Vision+API;Turn+Images+into+Descriptions" alt="Typing SVG" />
</div>

# AI Vision App 🤖

A Flutter application that uses OpenAI's Vision API to analyze images and provide detailed descriptions. Simply take a photo or choose one from your gallery, and let AI tell you what it sees!

<div align="center">
  <img src="assets/sample/VisionAI_Testing.gif" width="300" alt="Demo GIF"/>
</div>

## ✨ Features

<details>
<summary>📸 Image Handling</summary>

- Camera integration for instant photo capture
- Gallery access for existing images
- Image quality optimization (84% quality)
- Maximum resolution: 1920x1080
- File size limit: 10MB
</details>

<details>
<summary>🤖 AI Integration</summary>

- Powered by OpenAI's Vision API
- Real-time image analysis
- Detailed scene descriptions
- Error handling and user feedback
</details>

<details>
<summary>🎨 UI Features</summary>

- Material Design 3.0
- Clean and intuitive interface
- Loading indicators
- Error notifications via SnackBar
- Responsive layout
- Custom theme with deep purple accent
</details>

## 📱 Screenshots

<div align="center">
  <table>
    <tr>
      <td><img src="assets/sample/Screenshot 2025-02-13 094836.png" width="250" alt="Screenshot 1"/></td>
      <td><img src="assets/sample/Screenshot 2025-02-13 095547.png" width="250" alt="Screenshot 2"/></td>
      <td><img src="assets/sample/Screenshot 2025-02-13 095619.png" width="250" alt="Screenshot 3"/></td>
    </tr>
  </table>
</div>

## 🚀 Getting Started

### Prerequisites
- Flutter SDK
- OpenAI API Key
- Android Studio / VS Code
- Git

### Installation

1. Clone the repository

2. Install dependencies

```bash
flutter pub get
```

3. Create a `.env` file in the root directory and add your OpenAI API key
```env
OPENAI_API_KEY=your_api_key_here
```

4. Run the app
```bash
flutter run
```

## 📁 Project Structure

<details>
<summary>📱 lib/home_page.dart</summary>

- Main UI implementation
- Image picking logic
- AI analysis integration
- State management
- Error handling
</details>

<details>
<summary>🔌 lib/openai_service.dart</summary>

- OpenAI API integration
- Image processing
- API response handling
- Error management
</details>

<details>
<summary>🎨 lib/main.dart</summary>

- App initialization
- Theme configuration
- Environment setup
- Root widget setup
</details>

## 🛠️ Built With

- [Flutter](https://flutter.dev/) - UI Framework
- [OpenAI API](https://openai.com/api/) - Vision AI
- [image_picker](https://pub.dev/packages/image_picker) - Image Selection
- [http](https://pub.dev/packages/http) - API Calls
- [flutter_dotenv](https://pub.dev/packages/flutter_dotenv) - Environment Management


## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

---

<div align="center">
  <p>If you like this project, please give it a ⭐️</p>
  <p>Made with ❤️ by Your Name</p>
</div>
