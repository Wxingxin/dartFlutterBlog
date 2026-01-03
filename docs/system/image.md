下面给你一份 **Flutter 图片选择神器 `image_picker` 学习大全**，从 **安装 → 拍照/相册 → 权限 → 实战 → 常见坑** 一步到位，直接能上项目。

---

## 一、image_picker 是什么？能干嘛？

> **image_picker = 从相册选图 / 调用相机拍照（官方插件）**

### 常见用途

* 头像上传
* 表单图片选择
* 发布动态 / 发帖
* OCR、图片识别前置步骤

---

## 二、安装与基础配置

### 1️⃣ 添加依赖

```yaml
dependencies:
  image_picker: ^1.0.7
```

---

## 三、最基础用法（必会）

### 1️⃣ 创建 ImagePicker

```dart
import 'package:image_picker/image_picker.dart';

final ImagePicker picker = ImagePicker();
```

---

### 2️⃣ 从相册选择图片

```dart
final XFile? image =
    await picker.pickImage(source: ImageSource.gallery);

if (image != null) {
  print(image.path);
}
```

---

### 3️⃣ 使用相机拍照

```dart
final XFile? photo =
    await picker.pickImage(source: ImageSource.camera);
```

---

## 四、在 Widget 中完整使用示例（最常用）

![Image](https://i.sstatic.net/fhxUr.jpg)

![Image](https://blog.logrocket.com/wp-content/uploads/2021/07/flutter-image-picker-camera-1.png)

![Image](https://fluttergems.dev/media-cards/avatar_glow.gif)

```dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickImageDemo extends StatefulWidget {
  const PickImageDemo({super.key});

  @override
  State<PickImageDemo> createState() => _PickImageDemoState();
}

class _PickImageDemoState extends State<PickImageDemo> {
  final ImagePicker _picker = ImagePicker();
  File? _imageFile;

  Future<void> _pickFromGallery() async {
    final XFile? image =
        await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
      });
    }
  }

  Future<void> _pickFromCamera() async {
    final XFile? image =
        await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        _imageFile = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _imageFile == null
            ? const CircleAvatar(radius: 50, child: Icon(Icons.person))
            : CircleAvatar(
                radius: 50,
                backgroundImage: FileImage(_imageFile!),
              ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: _pickFromGallery,
          child: const Text('从相册选择'),
        ),
        ElevatedButton(
          onPressed: _pickFromCamera,
          child: const Text('拍照'),
        ),
      ],
    );
  }
}
```

---

## 五、图片压缩 / 尺寸控制（非常重要）

```dart
final XFile? image = await picker.pickImage(
  source: ImageSource.gallery,
  maxWidth: 800,
  maxHeight: 800,
  imageQuality: 80, // 0-100
);
```

### 参数说明

| 参数           | 作用        |
| ------------ | --------- |
| maxWidth     | 最大宽       |
| maxHeight    | 最大高       |
| imageQuality | JPEG 压缩质量 |

👉 **头像 / 上传图片强烈建议加**

---

## 六、选择多张图片（新版本支持）

```dart
final List<XFile> images = await picker.pickMultiImage(
  imageQuality: 80,
);

for (var img in images) {
  print(img.path);
}
```

---

## 七、权限配置（必踩坑）

### ✅ Android（android/app/src/main/AndroidManifest.xml）

```xml
<uses-permission android:name="android.permission.CAMERA"/>
<uses-permission android:name="android.permission.READ_MEDIA_IMAGES"/>
```

（Android 13+ 用 `READ_MEDIA_IMAGES`）

---

### ✅ iOS（ios/Runner/Info.plist）

```xml
<key>NSCameraUsageDescription</key>
<string>需要使用相机拍照</string>

<key>NSPhotoLibraryUsageDescription</key>
<string>需要访问相册选择图片</string>
```

❗ **没有这段，iOS 直接闪退**

---

## 八、常见实战场景

### ✅ 1️⃣ 上传头像（UI + 本地预览）

```dart
CircleAvatar(
  backgroundImage: FileImage(File(image.path)),
)
```

---

### ✅ 2️⃣ 上传服务器（示例）

```dart
final file = File(image.path);
// 用 dio / http 上传
```

---

### ✅ 3️⃣ 配合 shared_preferences 记录路径（不推荐长期）

```dart
prefs.setString('avatarPath', image.path);
```

⚠️ App 重装后路径可能失效

---

## 九、image_picker 常见坑（重点）

❗ **不要在 build 里调用 pickImage**
❗ iOS 一定要写权限说明
❗ Web 平台返回的是网络 URL
❗ Android 模拟器没有相机
❗ 大图不压缩直接 OOM

---

## 十、image_picker vs 其他方案

| 方案                   | 特点        |
| -------------------- | --------- |
| image_picker         | 官方、简单     |
| file_picker          | 选文件（不限图片） |
| wechat_assets_picker | 微信风格、多图   |
| camera               | 高级相机控制    |

👉 **80% 场景 image_picker 足够**

---

## 十一、一句话总结

> **image_picker = Flutter 图片入口的事实标准**
> 学会它，头像、上传、相册功能全打通。

---

如果你愿意，我可以下一步直接帮你写👇

* 🔹 **image_picker + 裁剪头像（image_cropper）**
* 🔹 **image_picker + 上传接口（dio）**
* 🔹 **image_picker + 表单 + 校验完整 Demo**

你挑一个，我马上给你整套可复制代码 💪
# eg

下面给你一套 **Flutter 中 `image_picker + image_cropper` 实现头像选择 + 裁剪** 的**完整、可直接用**方案，偏实战，复制就能跑 👍
（很适合你现在在系统学 Flutter）

---

## 一、整体流程（先搞清楚思路）

**流程一句话版：**

> 选图片 👉 返回图片路径 👉 裁剪 👉 得到头像文件 👉 显示 / 上传

**具体步骤：**

1. 使用 `image_picker`

   * 从 **相册 / 相机** 选择图片
2. 使用 `image_cropper`

   * 裁剪成 **正方形 / 圆形头像**
3. 将裁剪后的图片

   * 显示成头像
   * 或上传服务器

---

## 二、添加依赖（pubspec.yaml）

```yaml
dependencies:
  flutter:
    sdk: flutter

  image_picker: ^1.0.7
  image_cropper: ^5.0.1
```

执行：

```bash
flutter pub get
```

---

## 三、平台配置（非常重要）

### ✅ Android 配置

**android/app/src/main/AndroidManifest.xml**

```xml
<uses-permission android:name="android.permission.CAMERA"/>
<uses-permission android:name="android.permission.READ_MEDIA_IMAGES"/>
```

> Android 13 以下：

```xml
<uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE"/>
```

---

### ✅ iOS 配置

**ios/Runner/Info.plist**

```xml
<key>NSCameraUsageDescription</key>
<string>用于拍摄头像</string>
<key>NSPhotoLibraryUsageDescription</key>
<string>用于选择头像</string>
```

---

## 四、核心代码（头像选择 + 裁剪）

### 1️⃣ 导入

```dart
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
```

---

### 2️⃣ 示例页面（完整可用）

```dart
class AvatarPickerPage extends StatefulWidget {
  const AvatarPickerPage({super.key});

  @override
  State<AvatarPickerPage> createState() => _AvatarPickerPageState();
}

class _AvatarPickerPageState extends State<AvatarPickerPage> {
  File? _avatar;

  /// 选择图片
  Future<void> _pickImage() async {
    final picker = ImagePicker();

    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery, // or ImageSource.camera
      imageQuality: 80,
    );

    if (pickedFile == null) return;

    final croppedFile = await _cropImage(pickedFile.path);

    if (croppedFile == null) return;

    setState(() {
      _avatar = File(croppedFile.path);
    });
  }

  /// 裁剪图片
  Future<CroppedFile?> _cropImage(String path) async {
    return await ImageCropper().cropImage(
      sourcePath: path,
      aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1), // 1:1
      cropStyle: CropStyle.circle, // 圆形头像
      compressQuality: 90,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: '裁剪头像',
          toolbarColor: Colors.black,
          toolbarWidgetColor: Colors.white,
          hideBottomControls: true,
          lockAspectRatio: true,
        ),
        IOSUiSettings(
          title: '裁剪头像',
          aspectRatioLockEnabled: true,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('选择头像')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// 头像显示
            CircleAvatar(
              radius: 60,
              backgroundColor: Colors.grey.shade300,
              backgroundImage:
                  _avatar != null ? FileImage(_avatar!) : null,
              child: _avatar == null
                  ? const Icon(Icons.person, size: 60)
                  : null,
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('选择头像'),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## 五、效果说明（你能看到什么）

![Image](https://blog.logrocket.com/wp-content/uploads/2021/07/flutter-image-picker-gallery-3.png)

![Image](https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRl0IfKZGSrwIK-h-sXfW2aYlRyfwMPPIBnUrtDDkwMPdkIxtXYHXeQIgFfUZRimgDc8Bg\&usqp=CAU)

![Image](https://i.sstatic.net/MibcQ.png)

**用户体验：**

* 点击「选择头像」
* 打开系统相册
* 进入裁剪界面（圆形）
* 确认后立即显示成头像

---

## 六、常见配置改法（很实用）

### ✅ 改成方形裁剪

```dart
cropStyle: CropStyle.rectangle,
```

---

### ✅ 自由比例裁剪

```dart
aspectRatio: null,
lockAspectRatio: false,
```

---

### ✅ 限制图片大小（上传前）

```dart
imageQuality: 70, // image_picker
compressQuality: 80, // image_cropper
```

---

## 七、典型坑点（提前避雷）

### ❌ 裁剪界面打不开

👉 **90% 是权限或 iOS plist 没配**

---

### ❌ Android 13 无法选图

👉 必须加：

```xml
READ_MEDIA_IMAGES
```

---

### ❌ Web 不支持

👉 `image_cropper` **不支持 Flutter Web**

---

## 八、下一步你可以继续做的

如果你愿意，我可以继续帮你：

* ✅ 封装成一个 **AvatarPicker 组件**
* ✅ 加 **底部弹窗（相机 / 相册）**
* ✅ 头像上传（Dio + FormData）
* ✅ 和 `Form` / `TextFormField` 联动
* ✅ 实战：注册页 / 个人信息页

你想往 **哪个方向**继续？我直接给你进阶版本 👌
