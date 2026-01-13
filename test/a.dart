Future<String> fetchUser() async {
  await Future.delayed(Duration(seconds: 2));
  return '张三';
}

Future<void> main() async {
  try {
    final user = await fetchUser();
    print(user);
  } catch (e) {
    print('失败');
  } finally {
    print('结束');
  }
}
