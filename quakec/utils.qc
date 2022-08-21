/*

Open your browser console and put this in to generate the calls

{
    let str = "Welcome to Rocket-only deathmatch\n\nAny bugs are probably related to the mod\nHave fun!";
    let out = "";
    let buffer = [];
    let endBuffer = false;
    let newLine = false;

    for(let i=0;i<str.length;i++) {
        let c = str[i];
        if(c == '\n') {
            buffer.push('\\n');
            endBuffer = true;
            newLine = true;
        }
        else {
            buffer.push(c);
            if(buffer.length == 16)
                endBuffer = true;
        }
        
        if(i == str.length - 1)
            endBuffer = true;

        if(endBuffer) {
            out += "WriteChars(";
            for(let x=0;x<buffer.length;x++)
            {
                if(x > 0) out += ",";
                out += `'${buffer[x]}'`
            }
            out += ");"

            buffer = [];
            endBuffer = false;

            if(newLine) {
                newLine = false;
                out += "\n";
            }
        }
    }

    out;
}

*/

void(float c1 = -1
   , float c2 = -1
   , float c3 = -1
   , float c4 = -1
   , float c5 = -1
   , float c6 = -1
   , float c7 = -1
   , float c8 = -1
   , float c9 = -1
   , float c10 = -1
   , float c11 = -1
   , float c12 = -1
   , float c13 = -1
   , float c14 = -1
   , float c15 = -1
   , float c16 = -1
) WriteChars = 
{
    if(c1 >= 0) WriteByte(MSG_ONE,c1);
    if(c2 >= 0) WriteByte(MSG_ONE,c2);
    if(c3 >= 0) WriteByte(MSG_ONE,c3);
    if(c4 >= 0) WriteByte(MSG_ONE,c4);
    if(c5 >= 0) WriteByte(MSG_ONE,c5);
    if(c6 >= 0) WriteByte(MSG_ONE,c6);
    if(c7 >= 0) WriteByte(MSG_ONE,c7);
    if(c8 >= 0) WriteByte(MSG_ONE,c8);
    if(c9 >= 0) WriteByte(MSG_ONE,c9);
    if(c10 >= 0) WriteByte(MSG_ONE,c10);
    if(c11 >= 0) WriteByte(MSG_ONE,c11);
    if(c12 >= 0) WriteByte(MSG_ONE,c12);
    if(c13 >= 0) WriteByte(MSG_ONE,c13);
    if(c14 >= 0) WriteByte(MSG_ONE,c14);
    if(c15 >= 0) WriteByte(MSG_ONE,c15);
    if(c16 >= 0) WriteByte(MSG_ONE,c16);
}
