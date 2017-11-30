#include <vector>

#include "symbol.hpp"
#include "treenode.hpp"

TreeNode::TreeNode(const Symbol& symbol_) : symbol(symbol_)
{
    ;
}

void TreeNode::addNode(TreeNode& treeNode)
{
    this->subtrees.push_back(treeNode);
}

std::vector<Symbol> TreeNode::DFSPreOrder()
{
    std::vector<Symbol> terminals_vector;
    Symbol node_symbol = this->getSymbol();

    if (node_symbol.symbol_type == SymbolType::terminal_)
        terminals_vector.insert(terminals_vector.begin(), node_symbol);
    else
    {
        for (std::vector<TreeNode>::iterator it = this->subtrees.begin() ; it != this->subtrees.end(); it++)
            it->DFSPreOrder(terminals_vector);
    }

    return terminals_vector;
}

void TreeNode::DFSPreOrder(std::vector<Symbol>& terminals_vector)
{
    Symbol node_symbol = this->getSymbol();
    if (node_symbol.symbol_type == SymbolType::terminal_)
        terminals_vector.insert(terminals_vector.end(), node_symbol);
    else
    {
        for (std::vector<TreeNode>::iterator it = this->subtrees.begin() ; it != this->subtrees.end(); it++)
            it->DFSPreOrder(terminals_vector);
    }

}

Symbol TreeNode::getSymbol()
{
    return this->symbol;
}

/*void TreeNode::deleteTree() {
	for (std::vector<TreeNode>::iterator it = this->subtrees.begin() ; it != this->subtrees.end(); it++)
	{
		if (it->getSymbol().symbol_type == SymbolType::terminal_)
			delete *it;
		else
			it->deleteTree();
	}
}*/
