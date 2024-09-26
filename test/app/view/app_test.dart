import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_todos_bloc/counter/counter.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      expect(find.byType(CounterPage), findsOneWidget);
    });
  });
}
