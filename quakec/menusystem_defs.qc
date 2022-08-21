#define MENU_IMPULSE_BASE 200
#define MENU_MAX_OPTIONS 16

.void(float menu) menucallback;

void CreateMenu(string text);
void MenuChoice(string text);
void SendMenu(entity client,void(float menu) callback);