# KeyLibrary
Better Way To Create Key Binds / Key Handlers

```lua
-- Chad Way
local Key = loadstring(game:HttpGet('https://raw.githubusercontent.com/Perthys/KeyLibrary/main/main.lua'))()

local Test = Key.new({Enum.KeyCode.A, Enum.KeyCode.B, Enum.KeyCode.C}, function(self, Input)
    print(self.Key)
end) 

-- Virgin Way
game:GetService("UserInputService").InputEnded:Connect(function(Input, GameProcessedEvent)
    if Input.KeyCode == Enum.KeyCode.A then
        print("a")
    elseif Input.KeyCode == Enum.KeyCode.B then
        print("b")
    elseif Input.KeyCode == Enum.KeyCode.C then
        print("b")
    end
end)

Test:Unbind()
```

| Name    | Type                                                         | Description                                                                                                                                                                          |
|---------|--------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Key(s)  | EnumItem / Table **{required}**                              | This Argument is used for registering KeyBinds you may pass a table or a single enum item                                                                                            |
| Name    | String **{optional}__****{Default: Auto-Increment Integer}**  | This Argument is used to denominate the Key Bind,  Using a name multiple times will auto-increment it.  If you do not pass any value it will give a auto incrementing integer value. |
| Handler | Function **{required}**                                      | This Function is called when the KeyBind is activated.                                                                                                                               |
| Type    | String **{optional}__****{Default: Tap}**                     | This Argument is used for determining the KeyBind type, there are 3 types  {Tap, Toggle, Hold}                                                                                       |
