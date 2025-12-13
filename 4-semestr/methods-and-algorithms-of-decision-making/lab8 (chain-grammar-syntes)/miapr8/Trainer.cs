using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace miapr8
{

    public class Trainer
    {
        private List<string> _learningData;
        private List<List<GrammarElement>> _grammar;

        public Trainer(List<string> learningData)
        {
            _learningData = learningData;
            _grammar = null;
            learningData.Sort((a, b) => b.Length.CompareTo(a.Length));
            _grammar = new List<List<GrammarElement>>();
            _grammar.Add(new List<GrammarElement>());
        }

        public void CreateGrammar()
        {
            FirstStage();
            SecondStage();
            ThirdStage();
            AdjustRuleSet();
        }


        private void FirstStage()
        {
            foreach (var str in _learningData)
            {
                AddRulesForString(str);
            }
        }

        private void AddRulesForString(string str)
        {
            int cur = 0;
            for (var i = 0; i < str.Length - 2; i++)
            {
                bool notFound = true;
                if (_grammar.Count != 0)
                    foreach (var rule in _grammar[cur])
                    {
                        if (rule.A[0] == str[i] && rule.BVal != GrammarElement.Term && rule.BVal != GrammarElement.NoVal)
                        {
                            notFound = false;
                            cur = rule.BVal;
                        }
                    }

                if (notFound)
                {
                    _grammar[cur].Add(new GrammarElement(_grammar.Count, str[i].ToString()));
                    cur = _grammar.Count;
                    _grammar.Add(new List<GrammarElement>());
                }
            }

            bool leftTwo = str.Length != 1;
            if (leftTwo)
                foreach (var rule in _grammar[cur])
                {
                    if (rule.A[0] == str[str.Length - 2] && rule.BVal != GrammarElement.Term && rule.BVal != GrammarElement.NoVal)
                    {
                        leftTwo = false;
                        cur = rule.BVal;
                    }
                }

            if (leftTwo)
            {
                bool temp = true;

                foreach (var rule in _grammar[cur])
                {
                    if (rule.A == string.Concat(str[str.Length - 2], str[str.Length - 1]) && rule.BVal == GrammarElement.Term && rule.BVal != GrammarElement.NoVal)
                    {
                        temp = false;
                        cur = rule.BVal;
                    }
                }

                if (temp)
                {
                    _grammar[cur].Add(new GrammarElement(GrammarElement.Term, string.Concat(str[str.Length - 2], str[str.Length - 1])));
                }
            }
            else
            {
                bool temp = true;

                foreach (var rule in _grammar[cur])
                {
                    if (rule.A[0] == str[str.Length - 1] && rule.BVal != GrammarElement.Term && rule.BVal == GrammarElement.NoVal)
                    {
                        temp = false;
                        cur = rule.BVal;
                    }
                }

                if (temp)
                {
                    _grammar[cur].Add(new GrammarElement(GrammarElement.NoVal, str[str.Length - 1].ToString()));
                }
            }
        }

        class ReplaceInfo
        {
            public int A { get; set; }
            public int B { get; set; }
            public GrammarElement Rule { get; set; }

            public ReplaceInfo(int a, int b, GrammarElement rule = null)
            {
                A = a;
                B = b;
                Rule = rule;
            }
        }
        private void SecondStage()
        {
            Stack<ReplaceInfo> stack = new Stack<ReplaceInfo>();
            for (var index = 1; index < _grammar.Count; index++)
            {
                var list = _grammar[index];
                for (var i = 0; i < list.Count; i++)
                {
                    var rule = list[i];
                    bool notReplaced = true;
                    if (rule.BVal == GrammarElement.Term)
                    {

                        for (var index1 = 0; index1 < _grammar.Count && notReplaced; index1++)
                        {
                            var searchList = _grammar[index1];
                            for (var j = 0; j < searchList.Count && notReplaced; j++)
                            {
                                var searchRule = searchList[j];
                                if (searchRule.A[0] == rule.A[0] && searchRule.BVal != GrammarElement.Term && searchRule.BVal != GrammarElement.NoVal)
                                {

                                    for (var k = 0; k < _grammar[searchRule.BVal].Count && notReplaced; k++)
                                    {
                                        var termSearch = _grammar[searchRule.BVal][k];
                                        if (termSearch.BVal == GrammarElement.NoVal && termSearch.A[0] == rule.A[1])
                                        {
                                            stack.Push(new ReplaceInfo(index, index1, rule));
                                            notReplaced = false;

                                        }
                                    }

                                }
                            }
                        }

                    }
                }
            }

            while (stack.Count != 0)
            {
                MergeInRule(stack.Pop());
            }
        }

        private void MergeInRule(ReplaceInfo rule)
        {

            foreach (var list in _grammar)
            {
                foreach (var el in list)
                {
                    if (el.BVal == rule.A)
                    {
                        el.BVal = rule.B;
                    }
                }
            }

            foreach (var val in _grammar[rule.A])
            {
                if (!_grammar[rule.B].Contains(val))
                    _grammar[rule.B].Add(val);
            }

            _grammar[rule.A].Clear();
            if (rule.Rule != null)
            {
                _grammar[rule.B].Remove(rule.Rule);
            }

        }

        private void ThirdStage()
        {
            Stack<ReplaceInfo> toDelete = new Stack<ReplaceInfo>();
            for (int i = 0; i < _grammar.Count; i++)
            {
                for (int j = i + 1; j < _grammar.Count; j++)
                {

                    if (GetStringSet(i).SetEquals(GetStringSet(j)))
                    {
                        toDelete.Push(new ReplaceInfo(j, i));
                    }

                }
            }

            while (toDelete.Count != 0)
            {
                MergeInRule(toDelete.Pop());
            }
        }

        private void ProductAllString(int index, int maxStrLen, string str, HashSet<string> result)
        {
            if (str.Length >= maxStrLen - 1)
            {
                return;
            }

            foreach (var rule in _grammar[index])
            {
                if (rule.BVal == GrammarElement.Term || rule.BVal == GrammarElement.NoVal)
                {
                    result.Add(string.Concat(str, rule.A));
                }
                else
                {
                    ProductAllString(rule.BVal, maxStrLen, string.Concat(str, rule.A), result);
                }
            }
        }

        private HashSet<string> GetStringSet(int index, int maxLen = 0)
        {
            HashSet<string> result = new HashSet<string>();

            if (maxLen == 0)
            {
                maxLen = _grammar.Sum(rule => rule.Count) * 3 + 6;
            }

            ProductAllString(index, maxLen + 1, "", result);
            return result;
        }

        private void AdjustRuleSet()
        {
            Stack<int> toDelete = new Stack<int>();
            for (var i = 0; i < _grammar.Count; i++)
            {
                if (_grammar[i].Count == 0)
                {
                    foreach (var list in _grammar)
                    {
                        foreach (var el in list)
                        {
                            if (el.BVal >= i && el.BVal != GrammarElement.Term && el.BVal != GrammarElement.NoVal)
                            {
                                el.BVal--;
                            }
                        }
                    }
                    toDelete.Push(i);
                }
            }

            while (toDelete.Count != 0)
            {
                _grammar.RemoveAt(toDelete.Pop());
            }
        }

        public string OutputGrammarText()
        {
            StringBuilder str = new StringBuilder();
            for (var i = 0; i < _grammar.Count; i++)
            {
                for (var j = 0; j < _grammar[i].Count; j++)
                {
                    if (_grammar[i][j].BVal == GrammarElement.NoVal)
                    {
                        str.Append($"A{i}->{_grammar[i][j].A}");
                        str.Append(Environment.NewLine);
                    }
                    else if (_grammar[i][j].BVal == GrammarElement.Term)
                    {
                        str.Append($"A{i}->{_grammar[i][j].A} {_grammar[i][j].B}");
                        str.Append(Environment.NewLine);
                    }
                    else
                    {
                        if (i == 0)
                        {
                            str.Append($"S->{_grammar[i][j].A} A{_grammar[i][j].BVal}");
                            str.Append(Environment.NewLine);
                        }
                        else
                        {
                            str.Append($"A{i}->{_grammar[i][j].A} A{_grammar[i][j].BVal}");
                            str.Append(Environment.NewLine);
                        }
                    }
                }
            }

            return str.ToString();
        }
        public string[] GenerateStrings(int maxLen)
        {
            return GetStringSet(0, maxLen).ToArray();
        }

        public string GenerateString(int maxLen)
        {
            Random rand = new Random();
            int i = 0;
            int cur = 0;
            StringBuilder str = new StringBuilder();
            while (i < maxLen)
            {
                GrammarElement rule = _grammar[cur][rand.Next(_grammar[cur].Count)];
                str.Append(rule.A);
                if (rule.BVal != GrammarElement.Term && rule.BVal != GrammarElement.NoVal)
                {
                    cur = rule.BVal;
                }
                else
                {
                    break;
                }
                i++;
            }

            return str.ToString();
        }
    }
}