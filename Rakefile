desc 'Run xcodebuild'
task :build, [:action, :workspace, :scheme, :sdk, :destination] do |_, args|
  cmd = %W(
    xcodebuild #{args.action}
        -workspace #{args.workspace}.xcworkspace
        -scheme #{args.scheme}
        -sdk #{args.sdk}
        -destination #{args.destination}
        -configuration Debug
        ONLY_ACTIVE_ARCH=NO
  )

  sh "set -eu -o pipefail && #{cmd.join(' ')} | xcpretty -c"
end
