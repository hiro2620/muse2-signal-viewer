function initKeyInput()
    %INITKEYINPUT Initialize keyboard input config
    %   use Psychtoolbox
    
    % OSで共通のキー配置にする
    KbName('UnifyKeyNames');
    
    % いずれのキーも押されていない状態にするため１秒ほど待つ
    pause(0.5);
    
    % 無効にするキーの初期化
    DisableKeysForKbCheck([]);
    
    % 常に押されるキー情報を取得する
    [ keyIsDown, ~, keyCode ] = KbCheck;
    
    % 常に押されている（と誤検知されている）キーがあったら、それを無効にする
    if keyIsDown
        keys = find(keyCode); % keyCodeの表示
        keyName = KbName(keys); % キーの名前を表示
        DisableKeysForKbCheck(keys);
        fprintf('%sキーを無効にしました\n', keyName);
    end
end

