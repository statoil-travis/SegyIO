classdef SegySpec
% add comment here
    properties
        filename
        sample_format
        trace_sorting_format
        sample_indexes
        crossline_indexes
        inline_indexes
        offset_count
        first_trace_pos
        il_stride
        xl_stride
        trace_bsize
        t
        iline
        xline
    end

    methods

        function obj = SegySpec(filename, inline_field, crossline_field, t0)
            spec = segyspec_mex(filename, int32(inline_field), int32(crossline_field), t0);
            obj.filename = filename;

            if (isempty(spec))
                e = MException('SegySpec:NoSuchFile', 'File %s not found',filename);
                throw(e);
            end

            obj.sample_format = uint32(SegySampleFormat(spec.sample_format));
            obj.trace_sorting_format = TraceSortingFormat(spec.trace_sorting_format);
            obj.sample_indexes = spec.sample_indexes;
            obj.crossline_indexes = uint32(spec.crossline_indexes);
            obj.inline_indexes = uint32(spec.inline_indexes);
            obj.offset_count = uint32(spec.offset_count);
            obj.first_trace_pos = uint32(spec.first_trace_pos);
            obj.il_stride = spec.il_stride;
            obj.xl_stride = spec.xl_stride;
            obj.trace_bsize = spec.trace_bsize;
            obj.t = obj.sample_indexes;
            obj.iline = obj.inline_indexes;
            obj.xline = obj.crossline_indexes;
        end

    end

end
