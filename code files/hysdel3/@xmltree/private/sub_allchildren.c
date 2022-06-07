/*#include <stdio.h>*/
#include <stdlib.h>
#include "mex.h"

short *children;
long n_are_children;

void sub_allchildren(const mxArray * tree, const long root_id)
{
    mxArray *contents_field;
    double *contents;
    long child, c_size, i;
    
    contents_field = mxGetField(mxGetCell(tree, root_id), 0, "contents");
    c_size = mxGetN(contents_field)*mxGetM(contents_field);
    contents = mxGetPr(contents_field);
    
    /* printf("root_id: %d, length(contents): %d\n", root_id, c_size); */
    for (i=0; i<c_size; i++)
    {
        n_are_children++;
        child = (long)contents[i] - 1;
        children[child] = 1;
        sub_allchildren(tree, child);
    }
    
}

void mexFunction(int nlhs, mxArray * plhs[], int nrhs, const mxArray * prhs[])
{
    double *root_id_idx;
    long root_id, N_tree, i, cnt;
    double *out;
    
    n_are_children = 0;
    
    N_tree = mxGetN(prhs[0])*mxGetM(prhs[0]);
    children = mxCalloc(N_tree+1, sizeof(short));
    
    root_id_idx = (double *)mxGetPr(prhs[1]);
    root_id = (long)root_id_idx[0];

    sub_allchildren(prhs[0], root_id-1);
    plhs[0] = mxCreateDoubleMatrix(1, n_are_children, mxREAL);
    out = mxGetPr(plhs[0]);
    cnt = 0;
    for (i=0; i<N_tree; i++)
    {
        if (children[i]==1)
        {
            out[cnt++] = i+1;
            /* printf("%d, ", i+1); */
        }
    }
    /* printf("\n"); */
    
    
    
    mxFree(children);
    /*
    contents = mxGetField(mxGetCell(prhs[0], root_id), 0, "contents");
    
    
    
    input_buf = mxArrayToString(prhs[2]);

    name = mxGetField(mxGetCell(prhs[0], cell_idx), 0, "name");
    if (name == NULL)
    {
        plhs[0] = mxCreateLogicalScalar(0);
        return;
    }
    name_str = mxArrayToString(name);
    name_match = strcmp(name_str, input_buf, 3);
    
    if (name_match == 0)
    {
        plhs[0] = mxCreateLogicalScalar(1);
    } else {
        plhs[0] = mxCreateLogicalScalar(0);
    }
     */
    return;
}
