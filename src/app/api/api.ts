export * from './default.service';
import { DefaultService } from './default.service';
export * from './stack.service';
import { StackService } from './stack.service';
export const APIS = [DefaultService, StackService];
