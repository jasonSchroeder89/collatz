module libcollatz.functions;

int getNumSteps(const ref ulong target)
{
    ulong targetVal = target;
    int numSteps = 0;

    while (targetVal > 1)
    {
        if (targetVal % 2 == 0)
        {
            targetVal /= 2;
            numSteps++;
            continue;
        }
        
        else
        {
            targetVal = (targetVal * 3) + 1;
            numSteps++;
            continue;
        }
    }

    return numSteps;
}

unittest
{
    const ulong test1 = 1uL, test2 = 8uL, test3 = 3uL;
    
    assert(getNumSteps(test1) == 0);
    assert(getNumSteps(test2) == 3);
    assert(getNumSteps(test3) == 7);
}

string printCollatzSequence(const ref ulong target, const bool printTotal,
                            uint numPerLine = 1)
{
    import std.conv : to;
    
    ulong targetVal = target;
    int lineCounter = 0;
    int stepCount = 0;
    string sequence = "";

    while (targetVal > 1)
    {
        sequence ~= to!string(targetVal);
        lineCounter++;

        if (targetVal % 2 == 0)
        {
            targetVal /= 2;
            stepCount++;
        }

        else
        {
            targetVal = (targetVal * 3) + 1;
            stepCount++;
        }

        if (lineCounter == numPerLine)
        {
            sequence ~= "\n";
            lineCounter = 0;
        }

        else
        {
            sequence ~= " -> ";
        }
    }

    sequence ~= "1";

    if (printTotal)
        sequence ~= " (" ~ to!string(stepCount) ~ ")";
        
    return sequence;
}

unittest
{
    import std.stdio : writeln;
    
    const ulong test1 = 8uL, test2 = 3uL;
    
    assert(printCollatzSequence(test1, true, 10) == 
        "8 -> 4 -> 2 -> 1 (3)");

    assert(printCollatzSequence(test2, false, 7) == 
        "3 -> 10 -> 5 -> 16 -> 8 -> 4 -> 2\n1");
}