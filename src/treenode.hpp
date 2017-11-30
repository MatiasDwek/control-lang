#ifndef _TREENODE_HPP_
#define _TREENODE_HPP_

#include <vector>

#include "symbol.hpp"

class TreeNode
{
private:
    std::vector<TreeNode> subtrees;
    Symbol symbol;
public:
    TreeNode(const Symbol& symbol_);
    void addNode(TreeNode& treeNode);
    std::vector<Symbol> DFSPreOrder();
    void DFSPreOrder(std::vector<Symbol>& terminals_vector);
    Symbol getSymbol();
};

#endif
