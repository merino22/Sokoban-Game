#include <iostream>
#include <string>
#include <string.h>
#include <easm.h>
#include "rlutil.h"
#include <algorithm>
#include <cstdlib>
#include <cstdio>
#include <ctime>

#define waitkey rlutil::anykey("Press any key to continue...\n")
int map1[9][9] = {0};
void tree(int x, int y)
{
    std::string ch = " ";
            for(int i = 1; i <= 3; i++)
            {
                rlutil::locate(x, y+i-1);
                int amount = (i*2)-1;
                int pos = (3-i)+1;
                for(int j = 0; j < 7; j++)
                {
                    if(i != 3) //RIGHT HERE
                    {
                        if(j == pos)
                        {
                            int k = 0;
                            for(k = 0; k < amount; k++)
                            {
                                ch = "▒";
                                rlutil::setColor(2);
                                rlutil::setBackgroundColor(0);
                                std::cout << ch;
                            }
                            j = j + k-1;
                        }else
                        {
                            ch = " ";
                            rlutil::resetColor();
                            rlutil::setBackgroundColor(1);
                            std::cout << ch;
                        }
                    }else{
                        if(j == 3)
                        {
                            ch = "l";
                            rlutil::setColor(0);
                            rlutil::setBackgroundColor(rlutil::RED);
                            std::cout << ch;
                        }
                        else{
                            ch = " ";
                            rlutil::resetColor();
                            rlutil::setBackgroundColor(1);
                            std::cout << ch;
                        }
                    }
                }
                rlutil::resetColor();
                std::cout << '\n';
            }
}

void block(int x, int y)
{
    std::string a = "";
    for(int j = 0; j < 3; j++)
            {
                rlutil::locate(x, y+j);
                for(int i = 0; i < 7; i++)
                {

                    if((j % 2) == 0)
                    {
                        if(i == 2)
                        {
                            rlutil::setColor(rlutil::WHITE);
                            rlutil::setBackgroundColor(4);
                            rlutil::setColor(15);
                            a = "│";
                            std::cout << a;
                        } else{
                            a = "_";
                            rlutil::setBackgroundColor(4);
                            rlutil::setColor(15);
                            std::cout << a;
                        } 
                    }
                    else
                    {
                        if(i == 6)
                        {
                            a = "│";
                            rlutil::setColor(rlutil::WHITE);
                            rlutil::setBackgroundColor(4);
                            rlutil::setColor(15);
                            std::cout << a;
                        } else{
                            a = "_";
                            rlutil::setBackgroundColor(4);
                            rlutil::setColor(15);
                            std::cout << a;
                        }
                    }
                }
                rlutil::resetColor();
                std::cout << '\n';
            }
            return;
}

void printFloor(int x, int y)
{
    std::string f = "";
    rlutil::setBackgroundColor(7);
    rlutil::setColor(0);
    for(int i = 0; i < 3; i++)
    {
        rlutil::locate(x, y+i);
        for(int j = 0; j < 7; j++)
        {
            if(i == 0)
            {
                if(j == 0)
                {
                    f = "°";
                    std::cout << f;
                }
                else{
                    f = " ";
                    std::cout << f;
                }
            }else if(i == 1)
            {
                if(j == 6)
                {
                    f = "°";
                    std::cout << f; 
                }
                else{
                    f = " ";
                    std::cout << f;
                }
            }
            else{
                if(j == 0)
                {
                    f = "°";
                    std::cout << f; 
                }
                else{
                    f = " ";
                    std::cout << f;
                }
            }
        }
        std::cout << '\n';
    }
    return;
}

void box(int x, int y)
{
    std::string str = " ";
    rlutil::setBackgroundColor(3);
    rlutil::setColor(0);
    for(int i = 0; i < 3; i++)
    {
        rlutil::locate(x, y+i);
        for(int j = 0; j < 7; j++)
        {
            if(i == 0)
            {
                if(j == 0)
                {
                    str = "╔";
                    std::cout << str;
                }else if(j == 3)
                {
                    str = "╦";
                    std::cout << str;
                }else if(j == 6)
                {
                    str = "╗";
                    std::cout << str;
                }else{
                    str = "═";
                    std::cout << str;
                }
            }else if(i == 1)
            {
                if(j == 0)
                {
                    str = "╠";
                    std::cout << str;
                }else if(j == 3)
                {
                    str = "╬";
                    std::cout << str;
                }else if(j == 6)
                {
                    str = "╣";
                    std::cout << str;
                }else{
                    str = "═";
                    std::cout << str;
                }
            }else{
                if(j == 0)
                {
                    str = "╚";
                    std::cout << str;
                }else if(j == 3)
                {
                    str = "╩";
                    std::cout << str;
                }else if(j == 6)
                {
                    str = "╝";
                    std::cout << str;
                }else{
                    str = "═";
                    std::cout << str;
                }
            }
        }
        std::cout << "\n";
    }
    return;
}

void boxSpot(int x, int y)
{
    std::string str = " ";
    rlutil::setColor(7);
    for(int i = 0; i < 3; i++)
    {
        rlutil::locate(x, y+i);
        for(int j = 0; j < 7; j++)
        {
            if(i == 0)
            {
                if(j == 2)
                {
                    rlutil::setColor(7);
                    str = "\\";
                    std::cout << str;
                }else if(j == 4)
                {
                    rlutil::setColor(7);
                    str = "/";
                    std::cout << str;
                }else
                {
                    rlutil::resetColor();
                    str = " ";
                    std::cout << str;
                }
            }else if(i == 1)
            {
                if(j == 3)
                {
                    rlutil::setColor(7);
                    str = "X";
                    std::cout << str;
                }
                else{
                    rlutil::resetColor();
                    str = " ";
                    std::cout << str;
                }
            }else{
                if(j==2)
                {
                    rlutil::setColor(7);
                    str = "/";
                    std::cout << str;
                }else if(j == 4)
                {
                    rlutil::setColor(7);
                    str = "\\";
                    std::cout << str;
                }
                else{
                    rlutil::resetColor();
                    str = " ";
                    std::cout << str;
                }
            }
        }
        std::cout << "\n";
    }
    return;
}

void printPlayer(int x, int y)
{   
    int local_x = x;
    int local_y = y;
    std::string player = " ";
    rlutil::setBackgroundColor(7);
    for(int i = 0; i < 3; i++)
    {
        rlutil::locate(local_x, local_y+i);
        for(int j = 0; j < 7; j++)
        {
            if(i == 0)
            {
                rlutil::setColor(1);
                if(j == 1 || j == 5)
                {
                    player = "▄";
                    std::cout << player;
                }else if(j == 2 || j == 3 || j == 4)
                {
                    player = "█";
                    std::cout << player;
                }else
                {
                    player = " ";
                    std::cout << player;
                }
            }else if(i == 1)
            {
                rlutil::setColor(0);
                if(j == 1 || j == 5)
                {
                    player = "|";
                    std::cout << player;
                }else if(j == 2 || j == 4)
                {
                    player = "õ";
                    std::cout << player;
                }else if(j == 3)
                {
                    player = "_";
                    std::cout << player;
                }
                else
                {
                    player = " ";
                    std::cout << player;
                }
            }
            else
            {
                if(j == 1)
                {
                    player = "\\";
                    std::cout << player;
                }else if(j == 5)
                {
                    player = "/";
                    std::cout << player;
                }else if(j == 3)
                {
                    player = "─";
                    std::cout << player;
                }else{
                    player = " ";
                    std::cout << player;
                }
            }
        }
    }
}

void generateMap()
{
    map1[0][0] = 1;
    map1[0][1] = 1;
    map1[0][2] = 2;
    map1[0][3] = 2;
    map1[0][4] = 2;
    map1[0][5] = 1;
    map1[0][6] = 1;
    map1[0][7] = 1;
    map1[0][8] = 1;

    map1[1][0] = 1;
    map1[1][1] = 1;
    map1[1][2] = 2;
    map1[1][3] = 5;
    map1[1][4] = 2;
    map1[1][5] = 1;
    map1[1][6] = 1;
    map1[1][7] = 1;
    map1[1][8] = 1;

    map1[2][0] = 1;
    map1[2][1] = 1;
    map1[2][2] = 2;
    map1[2][3] = 0;
    map1[2][4] = 2;
    map1[2][5] = 2;
    map1[2][6] = 2;
    map1[2][7] = 2;
    map1[2][8] = 1;

    map1[3][0] = 2;
    map1[3][1] = 2;
    map1[3][2] = 2;
    map1[3][3] = 3;
    map1[3][4] = 0;
    map1[3][5] = 3;
    map1[3][6] = 5;
    map1[3][7] = 2;
    map1[3][8] = 1;

    map1[4][0] = 2;
    map1[4][1] = 5;
    map1[4][2] = 0;
    map1[4][3] = 3;
    map1[4][4] = 4;
    map1[4][5] = 2;
    map1[4][6] = 2;
    map1[4][7] = 2;
    map1[4][8] = 1;

    map1[5][0] = 2;
    map1[5][1] = 2;
    map1[5][2] = 2;
    map1[5][3] = 2;
    map1[5][4] = 3;
    map1[5][5] = 2;
    map1[5][6] = 1;
    map1[5][7] = 1;
    map1[5][8] = 1;

    map1[6][0] = 1;
    map1[6][1] = 1;
    map1[6][2] = 1;
    map1[6][3] = 2;
    map1[6][4] = 5;
    map1[6][5] = 2;
    map1[6][6] = 1;
    map1[6][7] = 1;
    map1[6][8] = 1;

    map1[7][0] = 1;
    map1[7][1] = 1;
    map1[7][2] = 1;
    map1[7][3] = 2;
    map1[7][4] = 2;
    map1[7][5] = 2;
    map1[7][6] = 1;
    map1[7][7] = 1;
    map1[7][8] = 1;

    map1[8][0] = 1;
    map1[8][1] = 1;
    map1[8][2] = 1;
    map1[8][3] = 1;
    map1[8][4] = 1;
    map1[8][5] = 1;
    map1[8][6] = 1;
    map1[8][7] = 1;
    map1[8][8] = 1;

    int x = 1, y = 1;
    for(int i = 0; i < 9; i++)
    {
        for(int j = 0; j < 9; j++)
        {
            if(map1[i][j] == 1)
            {
                tree(x,y);
            }
            else if(map1[i][j] == 2)
            {
                block(x, y);
            }else if(map1[i][j] == 3)
            {
                box(x,y);
            }else if(map1[i][j] == 4)
            {
                printPlayer(x,y);
            }else if(map1[i][j] == 5)
            {
                boxSpot(x,y);
            }
            x += 7;
        }
        x = 1;
        y += 3;
    }

}

bool checkPosY(int x, int y, int posMove, int arr[9][9])
{
    int l_x = (x - 1)/7;
    int l_y = (y - 1)/3;
    int l_posMove = posMove/3;
    int boxSum = 0;
    if(l_posMove < 0)
    {
        boxSum = -1;
    }
    else
    {
        boxSum = 1;
    }

    if(arr[l_y+l_posMove][l_x] == 2)
    {
        return false;
    }
    else if(arr[l_y+l_posMove][l_x] == 3)
    { 
        if(arr[l_y+l_posMove+ boxSum][l_x] == 0 || arr[l_y+l_posMove+ boxSum][l_x] == 5)
        {
            arr[l_y][l_x] = 0;
            arr[l_y+l_posMove][l_x] = 4;
            arr[l_y+l_posMove+boxSum][l_x] = 3;
            return true;
        }
        else
        {
            return false;
        }
    }
    else{
        arr[l_y][l_x] = 0;
        arr[l_y+l_posMove][l_x] = 4;
        return true;
    }
}

bool checkPosX(int x, int y, int posMove, int arr[9][9])
{
    int l_x = (x - 1)/7;
    int l_y = (y - 1)/3;
    int l_posMove = posMove/7;
    int boxSum = 0;
    if(l_posMove < 0)
    {
        boxSum = -1;
    }
    else
    {
        boxSum = 1;
    }

    if(arr[l_y][l_x + l_posMove] == 2)
    {
        return false;
    }
    else if(arr[l_y][l_x+l_posMove] == 3)
    { 
        if(arr[l_y][l_x+l_posMove+boxSum] == 0 || arr[l_y][l_x+l_posMove+boxSum] == 5)
        {
            arr[l_y][l_x] = 0;
            arr[l_y][l_x+l_posMove] = 4;
            arr[l_y][l_x+l_posMove+boxSum] = 3;
            return true;
        }
        else
        {
            return false;
        }
    }
    else
    {
        arr[l_y][l_x] = 0;
        arr[l_y][l_x+l_posMove] = 4;
        return true;
    }
}

void repaintBoxes()
{
    int x = 1, y = 1;
    for(int i = 0; i < 9; i++)
    {
        for(int j = 0; j < 9; j++)
        {
            if(map1[i][j] == 3)
            {
                box(x, y);
            }
            x += 7;
        }
        x = 1;
        y += 3;
    }
}

void erasePlayer(int x, int y)
{
    int local_x = x;
    int local_y = y;
    char player = ' ';
    rlutil::resetColor();
    for(int i = 0; i < 3; i++)
    {
        rlutil::locate(local_x, local_y+i);
        for(int j = 0; j < 7; j++)
        {
            std::cout << player;
        }
    }
}

bool lvlPassed(int arr[9][9])
{
    for(int i = 0; i < 9; i++)
    {
        for(int j = 0; j < 9; j++)
        {
            if(arr[i][j] == 5)
            {
                return false;
            }
        }
    }
    return true;
}

extern "C" ErrorCode handleSyscall(uint32_t *regs, void *mem, MemoryMap *mem_map)
{
    unsigned v0 = regs[Register::v0];
    unsigned a0 = regs[Register::a0];
    unsigned a1 = regs[Register::a1];
    unsigned a2 = regs[Register::a2];
    unsigned a3 = regs[Register::a3];

    switch (v0)
    {
        case 45:
        {
            
            return ErrorCode::Ok;
        }
        case 50:
        {
            if(kbhit())
            {
                regs[Register::v0] = 1;
            }
            else
            {
                regs[Register::v0] = 0;
            }
            return ErrorCode::Ok;
        }
        case 51:
        {
            rlutil::locate(a1, a2);
            return ErrorCode::Ok;
        }
        case 52:
        {
            rlutil::hidecursor();
            return ErrorCode::Ok;
        }
        case 53:
        {
            rlutil::cls();
            return ErrorCode::Ok;
        }
        case 20:
        {
            int a0 = regs[Register::a0];
            int a1 = regs[Register::a1];
            regs[Register::v0] = a0 + a1;
            return ErrorCode::Ok;
        }
        case 21:
        {
            generateMap();
            return ErrorCode::Ok;
        }
        case 27:
        {
            switch(a0)
            {
                case 32:
                {
                    std::cout << " ";
                    return ErrorCode::Ok;
                }
                case 47:
                {
                    std::cout << "/";
                    return ErrorCode::Ok;
                }
                case 88:
                {
                    std::cout << "X";
                    return ErrorCode::Ok;
                }
                case 92:
                {
                    std::cout << "\\";
                    return ErrorCode::Ok;
                }
                case 95:
                {
                    std::cout << "_";
                    return ErrorCode::Ok;
                }
                case 170:
                {
                    std::cout << "¬";
                    return ErrorCode::Ok;
                }
                case 176:
                {
                    std::cout << "░";
                    return ErrorCode::Ok;
                }
                case 179:
                {
                    std::cout << "│";
                    return ErrorCode::Ok;
                }
                case 185:
                {
                    std::cout << "╣";
                    return ErrorCode::Ok;
                }
                case 186:
                {
                    std::cout << "║";
                    return ErrorCode::Ok;
                }
                case 187:
                {
                    std::cout << "╗";
                    return ErrorCode::Ok;
                }
                case 188:
                {
                    std::cout << "╝";
                    return ErrorCode::Ok;
                }
                case 196:
                {
                    std::cout << "─";
                    return ErrorCode::Ok;
                }
                case 200:
                {
                    std::cout << "╚";
                    return ErrorCode::Ok;
                }
                case 201:
                {
                    std::cout << "╔";
                    return ErrorCode::Ok;
                }
                case 202:
                {
                    std::cout << "╩";
                    return ErrorCode::Ok;
                }
                case 203:
                {
                    std::cout << "╦";
                    return ErrorCode::Ok;
                }
                case 204:
                {
                    std::cout << "╠";
                    return ErrorCode::Ok;
                }
                case 205:
                {
                    std::cout << "═";
                    return ErrorCode::Ok;
                }
                case 206:
                {
                   std::cout << "╬";
                    return ErrorCode::Ok; 
                }
                case 219:
                {
                    std::cout << "█";
                    return ErrorCode::Ok;
                }
                case 220:
                {
                    std::cout << "▄";
                    return ErrorCode::Ok;
                }
                case 228:
                {
                    std::cout << "õ";
                    return ErrorCode::Ok;
                }
                case 248:
                {
                    std::cout << "°";
                    return ErrorCode::Ok;
                }
            }
            return ErrorCode::Ok;
        }
        case 28:
        {
            rlutil::setColor(a0);
            return ErrorCode::Ok;
        }
        case 29:
        {
            rlutil::setBackgroundColor(a0);
            return ErrorCode::Ok;
        }
        case 30:
        {
            rlutil::resetColor();
            return ErrorCode::Ok;
        }
        case 31:
        {
            kbhit();
            regs[Register::v0] = getch();
            /*
            while(1)
            {
                if(kbhit())
                {
                    regs[Register::v0] = 1;
                    char sk = getch();
                    std::cout << "sk: " << sk;
                }else{
                    regs[Register::v0] = 0;
                }
            }
            */
            return ErrorCode::Ok;
        }
        case 32:
        {
            regs[Register::v0] = getch();
            return ErrorCode::Ok;
        }
        case 26:
        {
        	int x = 29; int y = 13; unsigned int cnt = 0;
            rlutil::hidecursor();
            rlutil::cls();
            //std::cout << "Test 8: Non-blocking keyboard input" << std::endl;
            //std::cout << "You should be able to move the '@' character with WASD keys." << std::endl;
            //std::cout << "Hit Space to continue to the next test." << std::endl;
            //std::cout << "BruhTurn count: " << cnt << std::endl;
            rlutil::locate(x,y); //std::cout << '@' << std::endl; // Output player
            //printPlayer(x,y);
            generateMap();
            bool lvlOver = false;
            while (lvlOver == false) {
                //rlutil::locate(1,4); std::cout << "Turn count: " << cnt;
                if (kbhit()) {
                    char k = getch(); // Get character
                    rlutil::locate(x,y); //std::cout << " "; // Erase player
                    erasePlayer(x, y);
                    //rlutil::locate(x,y);
                    if (k == 'a')
                    {
                        if(checkPosX(x, y, -7, map1))
                        {
                            x=x-7;
                        }
                    } 
                    else if (k == 'd')
                    {
                        if(checkPosX(x, y, 7, map1))
                        {
                            x=x+7;
                        }
                    }
                    else if (k == 'w')
                    {
                        if(checkPosY(x, y, -3, map1))
                        {
                            y=y-3;
                        }
                    }
                    else if (k == 's')
                    {
                        if(checkPosY(x, y, 3, map1))
                        {
                            y=y+3;
                        }
                    }
                    else if (k == ' ') break;
                    rlutil::locate(x,y); //std::cout << '@'; // Output player
                    printPlayer(x, y);
                    repaintBoxes();
                    if(lvlPassed(map1))
                    {
                        lvlOver = true;
                    }
                }
                cnt++;
                std::cout.flush();
            }
            rlutil::showcursor();
            return ErrorCode::Ok;
        }
        default:
            if (v0 > 20 && v0 <= 60)
            {
                std::cout << "Syscall: " << v0 << '\n' << std::flush;
                return ErrorCode::Ok;
            }
            else
            {
                return ErrorCode::SyscallNotImplemented;
            }
    }
}
