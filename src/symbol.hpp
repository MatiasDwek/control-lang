#ifndef _SYMBOLTYPE_HPP_
#define _SYMBOLTYPE_HPP_

#include <string>


enum class SymbolID
{
    // Terminals
    while_, lparen_, rparen_, lcurly_, rcurly_, if_, else_,
    repeat_, semicol_, pause_, outstring_, outint_, lclick_, rclick_,
    lrelease_, rrelease_, up_, down_, left_, right_, presskey_, releasekey_,
    id_, eqass_, or_, and_, eqcomp_, ne_, lt_, le_, gt_, ge_, add_, sub_,
    mul_, div_, mod_, opp_, int_, inint_, mouseposx_, mouseposy_,
    instring_, string_, string_t_, int_t_,
    
    // Non terminals
    file_, statement_, definition_, assignment_,
    type_, expression_, conjunction_, equality_, equop_, relation_, relop_, addition_,
    addop_, term_, mulop_, factor_, unaryop_, primary_, fuint_, fustring_, reint_, restring_,
    
    // Additional for translation
    post_repeat_, post_pause_, post_up_, post_down_, post_left_, post_right_, post_presskey_,
    post_releasekey_, post_mouseposx_, post_mouseposy_
};

enum class SymbolType
{
    terminal_, non_terminal_
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
    std::string getString();
};

#endif
