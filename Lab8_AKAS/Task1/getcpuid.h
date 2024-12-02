#pragma pack(push,1)
struct cpu_id {
 uint32_t raw;
 uint8_t stepping;
 uint8_t model;
 uint8_t family;
};
#pragma pack(pop)
extern "C" {
cpu_id getcpuid();
}
