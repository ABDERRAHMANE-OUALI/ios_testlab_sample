flutter build ios --config-only integration_test/example_test.dart
flutter build ios integration_test/example_test.dart --release 
cd ios
xcodebuild build-for-testing \
  -workspace Runner.xcworkspace \
  -scheme Runner \
  -xcconfig Flutter/Release.xcconfig \
  -configuration Release \
  -derivedDataPath \
  "../build/ios_integ" -sdk iphoneos

cd ..
cd build/ios_integ/Build/Products
zip -r "ios_tests.zip" "Release-iphoneos" *.xctestrun 
cd -
gcloud firebase test ios run \
  --test "build/ios_integ/Build/Products/ios_tests.zip"