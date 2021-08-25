# Uncomment the next line to define a global platform for your project
 platform :ios, '10.0'

target 'PetDiary' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for PetDiary
  
  # add the Firebase pod for Google Analytics
  pod 'Firebase/Analytics'
  pod 'Firebase/Auth'
  pod 'Firebase/Firestore'
  pod 'Firebase/Core'
  pod 'Firebase/Storage'
  
  #handle crash problem
  pod 'Fabric', '~> 1.10.2'
  pod 'Crashlytics', '~> 3.14.0'
  
  
  #add the decodable pod for Firebase
  pod 'FirebaseFirestoreSwift', '8.3.0-beta'

  target 'PetDiaryTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'PetDiaryUITests' do
    # Pods for testing
  end

end
