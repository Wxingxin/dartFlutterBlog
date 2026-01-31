```dart

void main() {
    final x = "hello".duplicate();
    print(x);// hellohello
}

extension StringExtension on String {
    String duplicate() return (
        this + this;
    )
}

```
