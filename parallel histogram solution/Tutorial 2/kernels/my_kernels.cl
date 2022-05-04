//a simple OpenCL kernel which copies all pixels from A to B
kernel void identity(global const uchar* A, global uchar* B) {
	int id = get_global_id(0);
	B[id] = A[id];
}
#define HIST_BINS 256

kernal void histogram(__global int* data, int numData, __global int* histogram) {

	int localHist[HISTBINS];
	int lID = get_local_id(0);
	int gID = get_global_id(0);

	for (int i = lID; i < HIST_BINS; i += get_local_size(0))
	{
		localHistogram[i] = 0;
	}
	barrier(CLK_LOCAL_MEM_FENCE);

	for (intr i = gID; i < numData; i += get_global_size(0))
	{
		atomic_add(&localHistogram[data[i]], 1);
	}

	for (int i = lID; i < HIST_BINS; i += get_local_size(0))
	{
		atomic_add(&histogram[i], localHistogram[i]);
	}

	//cl_int;
	//clEnqueueFillBuffer(cl_command_queue command_queue, cl_mem buffer, const void* pattern, size_t pattern_size, size_t offset, size_t size, cl_uint num_events_in_wait_list, const cl_event * event_wait_list, cl_event * event);


}