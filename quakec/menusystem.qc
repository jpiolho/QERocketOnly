string menu_text;
string menu_option[MENU_MAX_OPTIONS];
float menu_options;

void CreateMenu(string text) {
    menu_text = text;
    menu_options = 0;
}

void MenuChoice(string text) {
    if(menu_options >= MENU_MAX_OPTIONS)
        objerror("Too many menu options");

    menu_option[menu_options++] = text;
}

void SendMenu(entity client,void(float menu) callback) {
    client.menucallback = callback;

    prompt(client,menu_text,menu_options);

    for(float i=0;i<menu_options;i++) {
        promptchoice(client,menu_option[i],MENU_IMPULSE_BASE + i);
    }
}

__wrap void() ImpulseCommands = {

    // Handle menu callbacks
    if(self.menucallback != __NULL__) {
        if(self.impulse >= MENU_IMPULSE_BASE && self.impulse < (MENU_IMPULSE_BASE + 16)) {
            void(float menu) callback = self.menucallback;
            self.menucallback = __NULL__;
            callback(self.impulse - MENU_IMPULSE_BASE);
            self.impulse = 0;
            return;
        }
    }

    prior();
}