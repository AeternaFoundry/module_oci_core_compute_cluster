resource "oci_core_compute_cluster" "core_compute_clusters" {
  for_each = var.core_compute_clusters

  availability_domain = each.value.availability_domain
  compartment_id      = each.value.compartment_id
  defined_tags        = each.value.defined_tags
  display_name        = each.value.display_name
  freeform_tags       = each.value.freeform_tags

  dynamic "placement_constraint_details" {
    for_each = each.value.placement_constraint_details != null ? [each.value.placement_constraint_details] : []
    content {
      hpc_island_id                = placement_constraint_details.value.hpc_island_id
      logical_placement_constraint = placement_constraint_details.value.logical_placement_constraint
      target_memory_fabric_ids     = placement_constraint_details.value.target_memory_fabric_ids
      target_network_block_ids     = placement_constraint_details.value.target_network_block_ids
      type                         = placement_constraint_details.value.type
    }
  }

  dynamic "timeouts" {
    for_each = each.value.timeouts != null ? [each.value.timeouts] : []
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      update = timeouts.value.update
    }
  }
}

