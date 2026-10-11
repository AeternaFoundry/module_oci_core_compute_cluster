variable "core_compute_clusters" {
  description = <<EOT
Map of core_compute_clusters, attributes below
Required:
    - availability_domain
    - compartment_id
Optional:
    - defined_tags
    - display_name
    - freeform_tags
    - placement_constraint_details (block):
        - hpc_island_id (optional)
        - logical_placement_constraint (optional)
        - target_memory_fabric_ids (optional)
        - target_network_block_ids (optional)
        - type (required)
    - timeouts (block):
        - create (optional)
        - delete (optional)
        - update (optional)
EOT

  type = map(object({
    availability_domain = string
    compartment_id      = string
    defined_tags        = optional(map(string))
    display_name        = optional(string)
    freeform_tags       = optional(map(string))
    placement_constraint_details = optional(object({
      hpc_island_id                = optional(string)
      logical_placement_constraint = optional(string)
      target_memory_fabric_ids     = optional(list(string))
      target_network_block_ids     = optional(list(string))
      type                         = string
    }))
    timeouts = optional(object({
      create = optional(string)
      delete = optional(string)
      update = optional(string)
    }))
  }))
  validation {
    condition = alltrue([
      for k, v in var.core_compute_clusters : (
        v.placement_constraint_details == null || (contains([for v in ["COMPUTE_CLUSTER"] : lower(v)], lower(v.placement_constraint_details.type)))
      )
    ])
    error_message = "must be one of: \"COMPUTE_CLUSTER\""
  }
}

