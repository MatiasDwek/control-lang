#ifndef _CONTROL_TREE_HPP_
#define _CONTROL_TREE_HPP_

#include <string>


enum class SymbolID
{
    WHILE, LPAREN, RPAREN, LCURLY, RCURLY, IF, ELSE,
    REPEAT, SEMICOL, PAUSE, OUTSTRING, OUTINT, LCLICK, RCLICK,
    LRELEASE, RRLEASE, UP, DOWN, LEFT, RIGHT, PRESSKEY, RELEASEKEY,
    ID, EQASS, OR, AND, EQCOMP, NE, LT, LE, GT, GE, ADD, SUB,
    MUL, DIV, MOD, OPP, INT, ININT, MOUSEPOSX, MOUSEPOSY,
    INSTRING, STRING, STRING_T, INT_T
};

enum class SymbolType
{
    TERMINAL, NON_TERMINAL
};

class Symbol
{
public:
    Symbol(SymbolID symbol_ID_, SymbolType symbol_type_) :
        symbol_ID(symbol_ID_), symbol_type(symbol_type_) {};
    Symbol(SymbolID symbol_ID_, SymbolType symbol_type_, std::string init_string) :
        symbol_ID(symbol_ID_), symbol_type(symbol_type_), value(init_string) {};
    Symbol(const Symbol& symbol) :
        symbol_ID(symbol.symbol_ID), symbol_type(symbol.symbol_type),
        value(symbol.value) {};
    SymbolID symbol_ID;
    SymbolType symbol_type;
    std::string value;
};

#endif
