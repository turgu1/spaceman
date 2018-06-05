# -*- encoding: utf-8 -*-
# stub: axlsx 2.1.0.pre ruby lib

Gem::Specification.new do |s|
  s.name = "axlsx".freeze
  s.version = "2.1.0.pre"

  s.required_rubygems_version = Gem::Requirement.new("> 1.3.1".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Randy Morgan".freeze, "Jurriaan Pruis".freeze]
  s.date = "2018-06-05"
  s.description = "    xlsx spreadsheet generation with charts, images, automated column width, customizable styles and full schema validation. Axlsx helps you create beautiful Office Open XML Spreadsheet documents ( Excel, Google Spreadsheets, Numbers, LibreOffice) without having to understand the entire ECMA specification. Check out the README for some examples of how easy it is. Best of all, you can validate your xlsx file before serialization so you know for sure that anything generated is going to load on your client's machine.\n".freeze
  s.email = "digital.ipseity@gmail.com".freeze
  s.files = [".yardopts".freeze, ".yardopts_guide".freeze, "CHANGELOG.md".freeze, "LICENSE".freeze, "README.md".freeze, "Rakefile".freeze, "examples/2010_comments.rb".freeze, "examples/anchor_swapping.rb".freeze, "examples/auto_filter.rb".freeze, "examples/basic_charts.rb".freeze, "examples/chart_colors.rb".freeze, "examples/colored_links.rb".freeze, "examples/conditional_formatting/example_conditional_formatting.rb".freeze, "examples/conditional_formatting/getting_barred.rb".freeze, "examples/conditional_formatting/hitting_the_high_notes.rb".freeze, "examples/conditional_formatting/scaled_colors.rb".freeze, "examples/conditional_formatting/stop_and_go.rb".freeze, "examples/data_validation.rb".freeze, "examples/example.rb".freeze, "examples/extractive.rb".freeze, "examples/image1.jpeg".freeze, "examples/ios_preview.rb".freeze, "examples/merge_cells.rb".freeze, "examples/no_grid_with_borders.rb".freeze, "examples/page_setup.rb".freeze, "examples/pivot_table.rb".freeze, "examples/pivot_test.rb".freeze, "examples/sheet_protection.rb".freeze, "examples/skydrive/real_example.rb".freeze, "examples/split.rb".freeze, "examples/styles.rb".freeze, "examples/underline.rb".freeze, "examples/wrap_text.rb".freeze, "lib/axlsx".freeze, "lib/axlsx.rb".freeze, "lib/axlsx/content_type".freeze, "lib/axlsx/content_type/abstract_content_type.rb".freeze, "lib/axlsx/content_type/content_type.rb".freeze, "lib/axlsx/content_type/default.rb".freeze, "lib/axlsx/content_type/override.rb".freeze, "lib/axlsx/doc_props".freeze, "lib/axlsx/doc_props/app.rb".freeze, "lib/axlsx/doc_props/core.rb".freeze, "lib/axlsx/drawing".freeze, "lib/axlsx/drawing/ax_data_source.rb".freeze, "lib/axlsx/drawing/axes.rb".freeze, "lib/axlsx/drawing/axis.rb".freeze, "lib/axlsx/drawing/bar_3D_chart.rb".freeze, "lib/axlsx/drawing/bar_series.rb".freeze, "lib/axlsx/drawing/bubble_chart.rb".freeze, "lib/axlsx/drawing/bubble_series.rb".freeze, "lib/axlsx/drawing/cat_axis.rb".freeze, "lib/axlsx/drawing/chart.rb".freeze, "lib/axlsx/drawing/d_lbls.rb".freeze, "lib/axlsx/drawing/drawing.rb".freeze, "lib/axlsx/drawing/graphic_frame.rb".freeze, "lib/axlsx/drawing/hyperlink.rb".freeze, "lib/axlsx/drawing/line_3D_chart.rb".freeze, "lib/axlsx/drawing/line_chart.rb".freeze, "lib/axlsx/drawing/line_series.rb".freeze, "lib/axlsx/drawing/marker.rb".freeze, "lib/axlsx/drawing/num_data.rb".freeze, "lib/axlsx/drawing/num_data_source.rb".freeze, "lib/axlsx/drawing/num_val.rb".freeze, "lib/axlsx/drawing/one_cell_anchor.rb".freeze, "lib/axlsx/drawing/pic.rb".freeze, "lib/axlsx/drawing/picture_locking.rb".freeze, "lib/axlsx/drawing/pie_3D_chart.rb".freeze, "lib/axlsx/drawing/pie_series.rb".freeze, "lib/axlsx/drawing/scaling.rb".freeze, "lib/axlsx/drawing/scatter_chart.rb".freeze, "lib/axlsx/drawing/scatter_series.rb".freeze, "lib/axlsx/drawing/ser_axis.rb".freeze, "lib/axlsx/drawing/series.rb".freeze, "lib/axlsx/drawing/series_title.rb".freeze, "lib/axlsx/drawing/str_data.rb".freeze, "lib/axlsx/drawing/str_val.rb".freeze, "lib/axlsx/drawing/title.rb".freeze, "lib/axlsx/drawing/two_cell_anchor.rb".freeze, "lib/axlsx/drawing/val_axis.rb".freeze, "lib/axlsx/drawing/view_3D.rb".freeze, "lib/axlsx/drawing/vml_drawing.rb".freeze, "lib/axlsx/drawing/vml_shape.rb".freeze, "lib/axlsx/package.rb".freeze, "lib/axlsx/rels".freeze, "lib/axlsx/rels/relationship.rb".freeze, "lib/axlsx/rels/relationships.rb".freeze, "lib/axlsx/stylesheet".freeze, "lib/axlsx/stylesheet/border.rb".freeze, "lib/axlsx/stylesheet/border_pr.rb".freeze, "lib/axlsx/stylesheet/cell_alignment.rb".freeze, "lib/axlsx/stylesheet/cell_protection.rb".freeze, "lib/axlsx/stylesheet/cell_style.rb".freeze, "lib/axlsx/stylesheet/color.rb".freeze, "lib/axlsx/stylesheet/dxf.rb".freeze, "lib/axlsx/stylesheet/fill.rb".freeze, "lib/axlsx/stylesheet/font.rb".freeze, "lib/axlsx/stylesheet/gradient_fill.rb".freeze, "lib/axlsx/stylesheet/gradient_stop.rb".freeze, "lib/axlsx/stylesheet/num_fmt.rb".freeze, "lib/axlsx/stylesheet/pattern_fill.rb".freeze, "lib/axlsx/stylesheet/styles.rb".freeze, "lib/axlsx/stylesheet/table_style.rb".freeze, "lib/axlsx/stylesheet/table_style_element.rb".freeze, "lib/axlsx/stylesheet/table_styles.rb".freeze, "lib/axlsx/stylesheet/xf.rb".freeze, "lib/axlsx/util".freeze, "lib/axlsx/util/accessors.rb".freeze, "lib/axlsx/util/constants.rb".freeze, "lib/axlsx/util/mime_type_utils.rb".freeze, "lib/axlsx/util/options_parser.rb".freeze, "lib/axlsx/util/parser.rb".freeze, "lib/axlsx/util/serialized_attributes.rb".freeze, "lib/axlsx/util/simple_typed_list.rb".freeze, "lib/axlsx/util/storage.rb".freeze, "lib/axlsx/util/string.rb".freeze, "lib/axlsx/util/validators.rb".freeze, "lib/axlsx/version.rb".freeze, "lib/axlsx/workbook".freeze, "lib/axlsx/workbook/defined_name.rb".freeze, "lib/axlsx/workbook/defined_names.rb".freeze, "lib/axlsx/workbook/shared_strings_table.rb".freeze, "lib/axlsx/workbook/workbook.rb".freeze, "lib/axlsx/workbook/workbook_view.rb".freeze, "lib/axlsx/workbook/workbook_views.rb".freeze, "lib/axlsx/workbook/worksheet".freeze, "lib/axlsx/workbook/worksheet/auto_filter".freeze, "lib/axlsx/workbook/worksheet/auto_filter/auto_filter.rb".freeze, "lib/axlsx/workbook/worksheet/auto_filter/filter_column.rb".freeze, "lib/axlsx/workbook/worksheet/auto_filter/filters.rb".freeze, "lib/axlsx/workbook/worksheet/break.rb".freeze, "lib/axlsx/workbook/worksheet/cell.rb".freeze, "lib/axlsx/workbook/worksheet/cell_serializer.rb".freeze, "lib/axlsx/workbook/worksheet/cfvo.rb".freeze, "lib/axlsx/workbook/worksheet/cfvos.rb".freeze, "lib/axlsx/workbook/worksheet/col.rb".freeze, "lib/axlsx/workbook/worksheet/col_breaks.rb".freeze, "lib/axlsx/workbook/worksheet/color_scale.rb".freeze, "lib/axlsx/workbook/worksheet/cols.rb".freeze, "lib/axlsx/workbook/worksheet/comment.rb".freeze, "lib/axlsx/workbook/worksheet/comments.rb".freeze, "lib/axlsx/workbook/worksheet/conditional_formatting.rb".freeze, "lib/axlsx/workbook/worksheet/conditional_formatting_rule.rb".freeze, "lib/axlsx/workbook/worksheet/conditional_formattings.rb".freeze, "lib/axlsx/workbook/worksheet/data_bar.rb".freeze, "lib/axlsx/workbook/worksheet/data_validation.rb".freeze, "lib/axlsx/workbook/worksheet/data_validations.rb".freeze, "lib/axlsx/workbook/worksheet/date_time_converter.rb".freeze, "lib/axlsx/workbook/worksheet/dimension.rb".freeze, "lib/axlsx/workbook/worksheet/header_footer.rb".freeze, "lib/axlsx/workbook/worksheet/icon_set.rb".freeze, "lib/axlsx/workbook/worksheet/merged_cells.rb".freeze, "lib/axlsx/workbook/worksheet/outline_pr.rb".freeze, "lib/axlsx/workbook/worksheet/page_margins.rb".freeze, "lib/axlsx/workbook/worksheet/page_set_up_pr.rb".freeze, "lib/axlsx/workbook/worksheet/page_setup.rb".freeze, "lib/axlsx/workbook/worksheet/pane.rb".freeze, "lib/axlsx/workbook/worksheet/pivot_table.rb".freeze, "lib/axlsx/workbook/worksheet/pivot_table_cache_definition.rb".freeze, "lib/axlsx/workbook/worksheet/pivot_tables.rb".freeze, "lib/axlsx/workbook/worksheet/print_options.rb".freeze, "lib/axlsx/workbook/worksheet/protected_range.rb".freeze, "lib/axlsx/workbook/worksheet/protected_ranges.rb".freeze, "lib/axlsx/workbook/worksheet/rich_text.rb".freeze, "lib/axlsx/workbook/worksheet/rich_text_run.rb".freeze, "lib/axlsx/workbook/worksheet/row.rb".freeze, "lib/axlsx/workbook/worksheet/row_breaks.rb".freeze, "lib/axlsx/workbook/worksheet/selection.rb".freeze, "lib/axlsx/workbook/worksheet/sheet_calc_pr.rb".freeze, "lib/axlsx/workbook/worksheet/sheet_data.rb".freeze, "lib/axlsx/workbook/worksheet/sheet_format_pr.rb".freeze, "lib/axlsx/workbook/worksheet/sheet_pr.rb".freeze, "lib/axlsx/workbook/worksheet/sheet_protection.rb".freeze, "lib/axlsx/workbook/worksheet/sheet_view.rb".freeze, "lib/axlsx/workbook/worksheet/table.rb".freeze, "lib/axlsx/workbook/worksheet/table_style_info.rb".freeze, "lib/axlsx/workbook/worksheet/tables.rb".freeze, "lib/axlsx/workbook/worksheet/worksheet.rb".freeze, "lib/axlsx/workbook/worksheet/worksheet_comments.rb".freeze, "lib/axlsx/workbook/worksheet/worksheet_drawing.rb".freeze, "lib/axlsx/workbook/worksheet/worksheet_hyperlink.rb".freeze, "lib/axlsx/workbook/worksheet/worksheet_hyperlinks.rb".freeze, "lib/schema".freeze, "lib/schema/dc.xsd".freeze, "lib/schema/dcmitype.xsd".freeze, "lib/schema/dcterms.xsd".freeze, "lib/schema/dml-chart.xsd".freeze, "lib/schema/dml-chartDrawing.xsd".freeze, "lib/schema/dml-compatibility.xsd".freeze, "lib/schema/dml-diagram.xsd".freeze, "lib/schema/dml-lockedCanvas.xsd".freeze, "lib/schema/dml-main.xsd".freeze, "lib/schema/dml-picture.xsd".freeze, "lib/schema/dml-spreadsheetDrawing.xsd".freeze, "lib/schema/dml-wordprocessingDrawing.xsd".freeze, "lib/schema/opc-contentTypes.xsd".freeze, "lib/schema/opc-coreProperties.xsd".freeze, "lib/schema/opc-digSig.xsd".freeze, "lib/schema/opc-relationships.xsd".freeze, "lib/schema/pml.xsd".freeze, "lib/schema/shared-additionalCharacteristics.xsd".freeze, "lib/schema/shared-bibliography.xsd".freeze, "lib/schema/shared-commonSimpleTypes.xsd".freeze, "lib/schema/shared-customXmlDataProperties.xsd".freeze, "lib/schema/shared-customXmlSchemaProperties.xsd".freeze, "lib/schema/shared-documentPropertiesCustom.xsd".freeze, "lib/schema/shared-documentPropertiesExtended.xsd".freeze, "lib/schema/shared-documentPropertiesVariantTypes.xsd".freeze, "lib/schema/shared-math.xsd".freeze, "lib/schema/shared-relationshipReference.xsd".freeze, "lib/schema/sml.xsd".freeze, "lib/schema/vml-main.xsd".freeze, "lib/schema/vml-officeDrawing.xsd".freeze, "lib/schema/vml-presentationDrawing.xsd".freeze, "lib/schema/vml-spreadsheetDrawing.xsd".freeze, "lib/schema/vml-wordprocessingDrawing.xsd".freeze, "lib/schema/wml.xsd".freeze, "lib/schema/xml.xsd".freeze, "test/benchmark.rb".freeze, "test/content_type".freeze, "test/content_type/tc_content_type.rb".freeze, "test/content_type/tc_default.rb".freeze, "test/content_type/tc_override.rb".freeze, "test/doc_props".freeze, "test/doc_props/tc_app.rb".freeze, "test/doc_props/tc_core.rb".freeze, "test/drawing".freeze, "test/drawing/tc_axes.rb".freeze, "test/drawing/tc_axis.rb".freeze, "test/drawing/tc_bar_3D_chart.rb".freeze, "test/drawing/tc_bar_series.rb".freeze, "test/drawing/tc_bubble_chart.rb".freeze, "test/drawing/tc_bubble_series.rb".freeze, "test/drawing/tc_cat_axis.rb".freeze, "test/drawing/tc_cat_axis_data.rb".freeze, "test/drawing/tc_chart.rb".freeze, "test/drawing/tc_d_lbls.rb".freeze, "test/drawing/tc_data_source.rb".freeze, "test/drawing/tc_drawing.rb".freeze, "test/drawing/tc_graphic_frame.rb".freeze, "test/drawing/tc_hyperlink.rb".freeze, "test/drawing/tc_line_3d_chart.rb".freeze, "test/drawing/tc_line_chart.rb".freeze, "test/drawing/tc_line_series.rb".freeze, "test/drawing/tc_marker.rb".freeze, "test/drawing/tc_named_axis_data.rb".freeze, "test/drawing/tc_num_data.rb".freeze, "test/drawing/tc_num_val.rb".freeze, "test/drawing/tc_one_cell_anchor.rb".freeze, "test/drawing/tc_pic.rb".freeze, "test/drawing/tc_picture_locking.rb".freeze, "test/drawing/tc_pie_3D_chart.rb".freeze, "test/drawing/tc_pie_series.rb".freeze, "test/drawing/tc_scaling.rb".freeze, "test/drawing/tc_scatter_chart.rb".freeze, "test/drawing/tc_scatter_series.rb".freeze, "test/drawing/tc_ser_axis.rb".freeze, "test/drawing/tc_series.rb".freeze, "test/drawing/tc_series_title.rb".freeze, "test/drawing/tc_str_data.rb".freeze, "test/drawing/tc_str_val.rb".freeze, "test/drawing/tc_title.rb".freeze, "test/drawing/tc_two_cell_anchor.rb".freeze, "test/drawing/tc_val_axis.rb".freeze, "test/drawing/tc_view_3D.rb".freeze, "test/drawing/tc_vml_drawing.rb".freeze, "test/drawing/tc_vml_shape.rb".freeze, "test/profile.rb".freeze, "test/rels".freeze, "test/rels/tc_relationship.rb".freeze, "test/rels/tc_relationships.rb".freeze, "test/stylesheet".freeze, "test/stylesheet/tc_border.rb".freeze, "test/stylesheet/tc_border_pr.rb".freeze, "test/stylesheet/tc_cell_alignment.rb".freeze, "test/stylesheet/tc_cell_protection.rb".freeze, "test/stylesheet/tc_cell_style.rb".freeze, "test/stylesheet/tc_color.rb".freeze, "test/stylesheet/tc_dxf.rb".freeze, "test/stylesheet/tc_fill.rb".freeze, "test/stylesheet/tc_font.rb".freeze, "test/stylesheet/tc_gradient_fill.rb".freeze, "test/stylesheet/tc_gradient_stop.rb".freeze, "test/stylesheet/tc_num_fmt.rb".freeze, "test/stylesheet/tc_pattern_fill.rb".freeze, "test/stylesheet/tc_styles.rb".freeze, "test/stylesheet/tc_table_style.rb".freeze, "test/stylesheet/tc_table_style_element.rb".freeze, "test/stylesheet/tc_table_styles.rb".freeze, "test/stylesheet/tc_xf.rb".freeze, "test/tc_axlsx.rb".freeze, "test/tc_helper.rb".freeze, "test/tc_package.rb".freeze, "test/util".freeze, "test/util/tc_mime_type_utils.rb".freeze, "test/util/tc_serialized_attributes.rb".freeze, "test/util/tc_simple_typed_list.rb".freeze, "test/util/tc_validators.rb".freeze, "test/workbook".freeze, "test/workbook/tc_defined_name.rb".freeze, "test/workbook/tc_shared_strings_table.rb".freeze, "test/workbook/tc_workbook.rb".freeze, "test/workbook/tc_workbook_view.rb".freeze, "test/workbook/worksheet".freeze, "test/workbook/worksheet/auto_filter".freeze, "test/workbook/worksheet/auto_filter/tc_auto_filter.rb".freeze, "test/workbook/worksheet/auto_filter/tc_filter_column.rb".freeze, "test/workbook/worksheet/auto_filter/tc_filters.rb".freeze, "test/workbook/worksheet/tc_break.rb".freeze, "test/workbook/worksheet/tc_cell.rb".freeze, "test/workbook/worksheet/tc_cfvo.rb".freeze, "test/workbook/worksheet/tc_col.rb".freeze, "test/workbook/worksheet/tc_color_scale.rb".freeze, "test/workbook/worksheet/tc_comment.rb".freeze, "test/workbook/worksheet/tc_comments.rb".freeze, "test/workbook/worksheet/tc_conditional_formatting.rb".freeze, "test/workbook/worksheet/tc_data_bar.rb".freeze, "test/workbook/worksheet/tc_data_validation.rb".freeze, "test/workbook/worksheet/tc_date_time_converter.rb".freeze, "test/workbook/worksheet/tc_header_footer.rb".freeze, "test/workbook/worksheet/tc_icon_set.rb".freeze, "test/workbook/worksheet/tc_outline_pr.rb".freeze, "test/workbook/worksheet/tc_page_margins.rb".freeze, "test/workbook/worksheet/tc_page_set_up_pr.rb".freeze, "test/workbook/worksheet/tc_page_setup.rb".freeze, "test/workbook/worksheet/tc_pane.rb".freeze, "test/workbook/worksheet/tc_pivot_table.rb".freeze, "test/workbook/worksheet/tc_pivot_table_cache_definition.rb".freeze, "test/workbook/worksheet/tc_print_options.rb".freeze, "test/workbook/worksheet/tc_protected_range.rb".freeze, "test/workbook/worksheet/tc_rich_text.rb".freeze, "test/workbook/worksheet/tc_rich_text_run.rb".freeze, "test/workbook/worksheet/tc_row.rb".freeze, "test/workbook/worksheet/tc_selection.rb".freeze, "test/workbook/worksheet/tc_sheet_calc_pr.rb".freeze, "test/workbook/worksheet/tc_sheet_format_pr.rb".freeze, "test/workbook/worksheet/tc_sheet_pr.rb".freeze, "test/workbook/worksheet/tc_sheet_protection.rb".freeze, "test/workbook/worksheet/tc_sheet_view.rb".freeze, "test/workbook/worksheet/tc_table.rb".freeze, "test/workbook/worksheet/tc_table_style_info.rb".freeze, "test/workbook/worksheet/tc_worksheet.rb".freeze, "test/workbook/worksheet/tc_worksheet_hyperlink.rb".freeze]
  s.homepage = "https://github.com/randym/axlsx".freeze
  s.licenses = ["MIT".freeze]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.2".freeze)
  s.rubygems_version = "2.7.6".freeze
  s.summary = "Excel OOXML (xlsx) with charts, styles, images and autowidth columns.".freeze
  s.test_files = ["test/tc_axlsx.rb".freeze, "test/stylesheet".freeze, "test/stylesheet/tc_font.rb".freeze, "test/stylesheet/tc_cell_protection.rb".freeze, "test/stylesheet/tc_border.rb".freeze, "test/stylesheet/tc_gradient_fill.rb".freeze, "test/stylesheet/tc_table_style.rb".freeze, "test/stylesheet/tc_styles.rb".freeze, "test/stylesheet/tc_color.rb".freeze, "test/stylesheet/tc_dxf.rb".freeze, "test/stylesheet/tc_cell_alignment.rb".freeze, "test/stylesheet/tc_num_fmt.rb".freeze, "test/stylesheet/tc_fill.rb".freeze, "test/stylesheet/tc_cell_style.rb".freeze, "test/stylesheet/tc_gradient_stop.rb".freeze, "test/stylesheet/tc_xf.rb".freeze, "test/stylesheet/tc_table_styles.rb".freeze, "test/stylesheet/tc_border_pr.rb".freeze, "test/stylesheet/tc_pattern_fill.rb".freeze, "test/stylesheet/tc_table_style_element.rb".freeze, "test/benchmark.rb".freeze, "test/tc_package.rb".freeze, "test/tc_helper.rb".freeze, "test/workbook".freeze, "test/workbook/worksheet".freeze, "test/workbook/worksheet/tc_sheet_calc_pr.rb".freeze, "test/workbook/worksheet/tc_page_set_up_pr.rb".freeze, "test/workbook/worksheet/tc_break.rb".freeze, "test/workbook/worksheet/tc_cfvo.rb".freeze, "test/workbook/worksheet/tc_page_margins.rb".freeze, "test/workbook/worksheet/tc_pivot_table_cache_definition.rb".freeze, "test/workbook/worksheet/tc_col.rb".freeze, "test/workbook/worksheet/tc_conditional_formatting.rb".freeze, "test/workbook/worksheet/tc_header_footer.rb".freeze, "test/workbook/worksheet/tc_data_validation.rb".freeze, "test/workbook/worksheet/tc_table.rb".freeze, "test/workbook/worksheet/tc_icon_set.rb".freeze, "test/workbook/worksheet/tc_rich_text.rb".freeze, "test/workbook/worksheet/tc_protected_range.rb".freeze, "test/workbook/worksheet/tc_color_scale.rb".freeze, "test/workbook/worksheet/tc_pane.rb".freeze, "test/workbook/worksheet/tc_date_time_converter.rb".freeze, "test/workbook/worksheet/tc_row.rb".freeze, "test/workbook/worksheet/tc_print_options.rb".freeze, "test/workbook/worksheet/tc_outline_pr.rb".freeze, "test/workbook/worksheet/tc_sheet_view.rb".freeze, "test/workbook/worksheet/tc_table_style_info.rb".freeze, "test/workbook/worksheet/tc_sheet_pr.rb".freeze, "test/workbook/worksheet/tc_cell.rb".freeze, "test/workbook/worksheet/tc_rich_text_run.rb".freeze, "test/workbook/worksheet/tc_comments.rb".freeze, "test/workbook/worksheet/tc_selection.rb".freeze, "test/workbook/worksheet/tc_worksheet_hyperlink.rb".freeze, "test/workbook/worksheet/tc_comment.rb".freeze, "test/workbook/worksheet/tc_data_bar.rb".freeze, "test/workbook/worksheet/auto_filter".freeze, "test/workbook/worksheet/auto_filter/tc_filters.rb".freeze, "test/workbook/worksheet/auto_filter/tc_auto_filter.rb".freeze, "test/workbook/worksheet/auto_filter/tc_filter_column.rb".freeze, "test/workbook/worksheet/tc_pivot_table.rb".freeze, "test/workbook/worksheet/tc_sheet_protection.rb".freeze, "test/workbook/worksheet/tc_worksheet.rb".freeze, "test/workbook/worksheet/tc_page_setup.rb".freeze, "test/workbook/worksheet/tc_sheet_format_pr.rb".freeze, "test/workbook/tc_workbook.rb".freeze, "test/workbook/tc_shared_strings_table.rb".freeze, "test/workbook/tc_defined_name.rb".freeze, "test/workbook/tc_workbook_view.rb".freeze, "test/doc_props".freeze, "test/doc_props/tc_core.rb".freeze, "test/doc_props/tc_app.rb".freeze, "test/rels".freeze, "test/rels/tc_relationships.rb".freeze, "test/rels/tc_relationship.rb".freeze, "test/util".freeze, "test/util/tc_simple_typed_list.rb".freeze, "test/util/tc_validators.rb".freeze, "test/util/tc_serialized_attributes.rb".freeze, "test/util/tc_mime_type_utils.rb".freeze, "test/content_type".freeze, "test/content_type/tc_content_type.rb".freeze, "test/content_type/tc_default.rb".freeze, "test/content_type/tc_override.rb".freeze, "test/drawing".freeze, "test/drawing/tc_ser_axis.rb".freeze, "test/drawing/tc_view_3D.rb".freeze, "test/drawing/tc_title.rb".freeze, "test/drawing/tc_num_val.rb".freeze, "test/drawing/tc_pic.rb".freeze, "test/drawing/tc_named_axis_data.rb".freeze, "test/drawing/tc_drawing.rb".freeze, "test/drawing/tc_marker.rb".freeze, "test/drawing/tc_num_data.rb".freeze, "test/drawing/tc_val_axis.rb".freeze, "test/drawing/tc_vml_drawing.rb".freeze, "test/drawing/tc_hyperlink.rb".freeze, "test/drawing/tc_str_val.rb".freeze, "test/drawing/tc_axes.rb".freeze, "test/drawing/tc_line_chart.rb".freeze, "test/drawing/tc_line_series.rb".freeze, "test/drawing/tc_axis.rb".freeze, "test/drawing/tc_scaling.rb".freeze, "test/drawing/tc_series_title.rb".freeze, "test/drawing/tc_vml_shape.rb".freeze, "test/drawing/tc_picture_locking.rb".freeze, "test/drawing/tc_two_cell_anchor.rb".freeze, "test/drawing/tc_one_cell_anchor.rb".freeze, "test/drawing/tc_graphic_frame.rb".freeze, "test/drawing/tc_chart.rb".freeze, "test/drawing/tc_scatter_chart.rb".freeze, "test/drawing/tc_bubble_series.rb".freeze, "test/drawing/tc_pie_3D_chart.rb".freeze, "test/drawing/tc_bubble_chart.rb".freeze, "test/drawing/tc_bar_series.rb".freeze, "test/drawing/tc_str_data.rb".freeze, "test/drawing/tc_pie_series.rb".freeze, "test/drawing/tc_cat_axis.rb".freeze, "test/drawing/tc_bar_3D_chart.rb".freeze, "test/drawing/tc_line_3d_chart.rb".freeze, "test/drawing/tc_cat_axis_data.rb".freeze, "test/drawing/tc_scatter_series.rb".freeze, "test/drawing/tc_series.rb".freeze, "test/drawing/tc_d_lbls.rb".freeze, "test/drawing/tc_data_source.rb".freeze, "test/profile.rb".freeze]

  s.installed_by_version = "2.7.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<nokogiri>.freeze, [">= 1.6.6"])
      s.add_runtime_dependency(%q<rubyzip>.freeze, [">= 1.2.1"])
      s.add_runtime_dependency(%q<htmlentities>.freeze, ["~> 4.3.4"])
      s.add_runtime_dependency(%q<mimemagic>.freeze, ["~> 0.3"])
      s.add_development_dependency(%q<yard>.freeze, [">= 0"])
      s.add_development_dependency(%q<kramdown>.freeze, [">= 0"])
      s.add_development_dependency(%q<timecop>.freeze, ["~> 0.6.1"])
    else
      s.add_dependency(%q<nokogiri>.freeze, [">= 1.6.6"])
      s.add_dependency(%q<rubyzip>.freeze, [">= 1.2.1"])
      s.add_dependency(%q<htmlentities>.freeze, ["~> 4.3.4"])
      s.add_dependency(%q<mimemagic>.freeze, ["~> 0.3"])
      s.add_dependency(%q<yard>.freeze, [">= 0"])
      s.add_dependency(%q<kramdown>.freeze, [">= 0"])
      s.add_dependency(%q<timecop>.freeze, ["~> 0.6.1"])
    end
  else
    s.add_dependency(%q<nokogiri>.freeze, [">= 1.6.6"])
    s.add_dependency(%q<rubyzip>.freeze, [">= 1.2.1"])
    s.add_dependency(%q<htmlentities>.freeze, ["~> 4.3.4"])
    s.add_dependency(%q<mimemagic>.freeze, ["~> 0.3"])
    s.add_dependency(%q<yard>.freeze, [">= 0"])
    s.add_dependency(%q<kramdown>.freeze, [">= 0"])
    s.add_dependency(%q<timecop>.freeze, ["~> 0.6.1"])
  end
end
