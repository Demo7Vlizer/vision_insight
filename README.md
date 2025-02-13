<div align="center">
  <img src="https://readme-typing-svg.demolab.com?font=Fira+Code&duration=3000&pause=1000&color=00FFB3&center=true&vCenter=true&width=435&lines=Welcome+to+AI+Vision+Chat+🤖;Powered+by+OpenAI's+Vision+API;Ask+Questions+About+Any+Image;Get+Intelligent+Responses" alt="Typing SVG" />
  
  <p align="center">
    <img src="https://raw.githubusercontent.com/Platane/snk/output/github-contribution-grid-snake.svg" alt="snake animation" />
  </p>
</div>

# AI Vision Chat App 🚀

A powerful Flutter application that combines OpenAI's Vision API with an intuitive chat interface. Upload images and have natural conversations about them with AI!

## ✨ Key Features

<details>
<summary>📱 Core Features</summary>

- Image capture from camera
- Gallery image selection
- Real-time AI image analysis
- Interactive chat interface
- Auto-scrolling messages
- Elegant animations
- Error handling & feedback
</details>

<details>
<summary>🎨 UI Components</summary>

### Chat Interface
- Custom chat bubbles
- User/AI message differentiation
- Loading indicators
- Smooth scrolling
- Input field with send button

### Image Handling
- Image preview container
- Camera/Gallery selection buttons
- Image quality optimization
- Size limit handling
</details>

<details>
<summary>🏗️ Project Structure</summary>

```
lib/
├── app/
│   ├── controllers/
│   │   ├── chat_controller.dart    # Chat logic & message handling
│   │   └── image_controller.dart   # Image processing & analysis
│   ├── models/
│   │   └── chat_message.dart      # Message data structure
│   ├── modules/
│   │   └── home/
│   │       └── views/
│   │           └── home_view.dart  # Main UI implementation
│   └── widgets/
│       ├── chat_bubble.dart       # Message bubble design
│       ├── chat_input.dart        # Input field component
│       └── chat_section.dart      # Chat list implementation
└── main.dart                      # App initialization
```
</details>

<details>
<summary>🔧 Technical Details</summary>

### Image Processing
- Max resolution: 1920x1080
- Quality compression: 84%
- Size limit: 10MB
- Supported formats: JPG, PNG

### State Management
- GetX for reactive state
- Efficient message handling
- Smooth UI updates
</details>

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (2.0 or higher)
- OpenAI API key
- Basic Flutter knowledge

### Installation Steps

1. Clone the repository
```bash
git clone https://github.com/yourusername/ai-vision-chat.git
```

2. Install dependencies
```bash
flutter pub get
```

3. Create `.env` file in root directory
```env
OPENAI_API_KEY=your_api_key_here
```

4. Run the app
```bash
flutter run
```

## 📱 Screenshots & Demo

<div align="center">
  <img src="assets/sample/VisionAI_Testing_2.gif" width="300" alt="App Demo"/>
  
  <table>
    <tr>
      <td><img src="assets/sample/Screenshot 2025-02-13 094836.png" width="200" alt="Home Screen"/></td>
      <td><img src="assets/sample/Screenshot 2025-02-13 095547.png" width="200" alt="Chat Interface"/></td>
      <td><img src="assets/sample/Screenshot 2025-02-13 095619.png" width="200" alt="Image Analysis"/></td>
    </tr>
  </table>
</div>

## 🛠️ Built With

- [Flutter](https://flutter.dev/) - UI Framework
- [GetX](https://pub.dev/packages/get) - State Management
- [OpenAI API](https://openai.com/api/) - Vision & Chat AI
- [image_picker](https://pub.dev/packages/image_picker) - Image Selection
- [flutter_dotenv](https://pub.dev/packages/flutter_dotenv) - Environment Config

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

<div align="center">
  <img src="https://readme-typing-svg.demolab.com?font=Fira+Code&duration=3000&pause=1000&color=00FFB3&center=true&vCenter=true&width=435&lines=Thank+you+for+visiting!;Star+⭐+if+you+like+it;Made+with+💙+by+Rahul" alt="Typing SVG" />
</div>

