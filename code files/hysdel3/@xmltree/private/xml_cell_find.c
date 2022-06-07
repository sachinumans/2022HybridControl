/*#include <stdio.h>*/
#include <stdlib.h>
#include "mex.h"


void mexFunction(int nlhs, mxArray * plhs[], int nrhs, const mxArray * prhs[])
{
    mxArray *name;
    double *idx;
    char *input_buf, *name_str;
    int name_match;
    unsigned int cell_idx;
    
    idx = (double *)mxGetPr(prhs[1]);
    cell_idx = (int)idx[0]-1;
    input_buf = mxArrayToString(prhs[2]);

    name = mxGetField(mxGetCell(prhs[0], cell_idx), 0, "name");
    if (name == NULL)
    {
        plhs[0] = mxCreateLogicalScalar(0);
        return;
    }
    name_str = mxArrayToString(name);
    name_match = strcmp(name_str, input_buf);
    
    if (name_match == 0)
    {
        plhs[0] = mxCreateLogicalScalar(1);
    } else {
        plhs[0] = mxCreateLogicalScalar(0);
    }
    return;
}
