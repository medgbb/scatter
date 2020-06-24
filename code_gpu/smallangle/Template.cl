/*****************************************************************************
 * Copyright (c) 2013-2016 Intel Corporation
 * All rights reserved.
 *
 * WARRANTY DISCLAIMER
 *
 * THESE MATERIALS ARE PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL INTEL OR ITS
 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY
 * OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THESE
 * MATERIALS, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * Intel Corporation is the author of the Materials, and requests that all
 * problem reports or change requests be submitted to it directly
 *****************************************************************************/
constant sampler_t sampler = CLK_NORMALIZED_COORDS_FALSE | CLK_ADDRESS_CLAMP | CLK_FILTER_NEAREST;

__kernel void Add(read_only image1d_t particle_x, read_only image1d_t particle_y, read_only image1d_t particle_z, read_only image1d_t imageA, read_only image1d_t imageB, read_only image1d_t imageC, write_only image1d_t imageOUT, float coefficient, int num, float f_q)
{
    const int x = get_global_id(0);
	int n;

	float resultOUT;
	float sum_cos;
	float sum_sin;
	float A = read_imagef(imageA, sampler, x).x * coefficient;
	float B = read_imagef(imageB, sampler, x).x * coefficient;
	float C = read_imagef(imageC, sampler, x).x * coefficient;
	
	for (sum_cos = 0, sum_sin = 0, n = 0; n < num; n++){
		sum_cos += f_q * cos(A * (read_imagef(particle_x, sampler, n).x) + B * (read_imagef(particle_y, sampler, n).x) + C * (read_imagef(particle_z, sampler, n).x));
		sum_sin += f_q * sin(A * (read_imagef(particle_x, sampler, n).x) + B * (read_imagef(particle_y, sampler, n).x) + C * (read_imagef(particle_z, sampler, n).x));
	}
	resultOUT = (sum_cos * sum_cos + sum_sin * sum_sin) / num;
	
    write_imagef(imageOUT, x, (float4)(resultOUT));
}