platform :ios, '8.0'
use_frameworks!

def shared_pods
    pod 'Alamofire', '~> 4.2.0'
    pod 'AlamofireObjectMapper', '~> 4.0'
    pod 'JGProgressHUD'
    pod 'Kingfisher', '~> 3.0'
    pod 'RealmSwift'
    pod 'Toaster', '~> 2.0'
end

target 'ProjetoTeste-UserSearchGitHub' do
    shared_pods
end

target 'ProjetoTeste-UserSearchGitHubTests' do
    shared_pods
end

target 'ProjetoTeste-UserSearchGitHubUITests' do
    shared_pods
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
